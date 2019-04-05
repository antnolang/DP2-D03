
package services;

import java.util.Collection;
import java.util.Date;
import java.util.List;
import java.util.Random;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.Assert;

import repositories.ApplicationRepository;
import security.LoginService;
import domain.Application;
import domain.Curriculum;
import domain.Hacker;
import domain.Position;
import domain.Problem;

@Service
@Transactional
public class ApplicationService {

	// Managed repository ---------------------------------------------
	@Autowired
	private ApplicationRepository	applicationRepository;

	// Supporting services -------------------------------------------

	@Autowired
	private PositionService			positionService;

	@Autowired
	private ProblemService			problemService;

	@Autowired
	private HackerService			hackerService;

	@Autowired
	private CompanyService			companyService;

	@Autowired
	private UtilityService			utilityService;


	//Constructor ----------------------------------------------------
	public ApplicationService() {
		super();
	}

	//Simple CRUD methods -------------------------------------------
	public Application create(final Position position) {
		Assert.isTrue(position.getIsFinalMode());
		Assert.isTrue(!(position.getIsCancelled()));
		Assert.isTrue(!(this.hackerService.originalCurricula().isEmpty()));
		Application result;
		Hacker hacker;
		Date moment;
		final Curriculum curriculum;
		final Problem problem;

		hacker = this.hackerService.findByPrincipal();

		Assert.isTrue(!(this.problemService.problemsWithoutAcceptedApplicationWithoutOwnApplication(position, hacker).isEmpty()));

		moment = this.utilityService.current_moment();
		curriculum = this.hackerService.originalCurricula().get(0);
		problem = this.getRandomProblem(this.problemService.problemsWithoutAcceptedApplicationWithoutOwnApplication(position, hacker));

		result = new Application();
		result.setHacker(hacker);
		result.setCurriculum(curriculum);
		result.setProblem(problem);
		result.setPosition(position);
		result.setStatus("PENDING");
		result.setApplicationMoment(moment);

		return result;
	}

	public Application save(final Application application) {
		Assert.notNull(application);
		Assert.isTrue(application.getPosition().getIsFinalMode());
		Assert.isTrue(!(application.getPosition().getIsCancelled()));

		Application result;
		Application applicationSaved;

		applicationSaved = this.applicationRepository.findOne(application.getId());

		if (application.getId() == 0) {
			Assert.isTrue(application.getStatus().equals("PENDING"));
			Assert.isTrue(!(this.problemService.problemsWithoutAcceptedApplicationWithoutOwnApplication(application.getPosition(), application.getHacker()).isEmpty()));
			Assert.isTrue(!(this.hackerService.originalCurricula().isEmpty()));
			Assert.isNull(application.getSubmittedMoment());
			Assert.isNull(application.getAnswer());
		} else {
			Assert.isTrue((applicationSaved.getPosition().equals(application.getPosition())));
			Assert.isTrue((applicationSaved.getHacker().equals(application.getHacker())));
			Assert.isTrue((applicationSaved.getCurriculum().equals(application.getCurriculum())));
			Assert.isTrue((applicationSaved.getApplicationMoment().equals(application.getApplicationMoment())));

			if (LoginService.getPrincipal().getAuthorities().toString().equals("[HACKER]")) {
				Assert.isTrue(this.hackerService.findByPrincipal().equals(application.getHacker()));
				if (application.getStatus().equals("PENDING")) {
					Assert.isNull(application.getSubmittedMoment());
					Assert.isTrue(!(application.getAnswer().equals(null)));
					Assert.isTrue(application.getCurriculum().getHacker().equals(this.hackerService.findByPrincipal()));

					Date moment;
					moment = this.utilityService.current_moment();

					application.setSubmittedMoment(moment);
					application.setStatus("SUBMITTED");
				}
			}

			if (LoginService.getPrincipal().getAuthorities().toString().equals("[COMPANY]")) {
				Assert.isTrue(this.companyService.findByPrincipal().equals(application.getHacker()));
				Assert.isTrue((applicationSaved.getSubmittedMoment().equals(application.getSubmittedMoment())));
				Assert.isTrue((applicationSaved.getAnswer().equals(application.getAnswer())));
				Assert.isTrue((applicationSaved.getCurriculum().equals(application.getCurriculum())));
				Assert.isTrue(applicationSaved.getStatus().equals("SUBMITTED"));

			}

		}

		result = this.applicationRepository.save(application);

		return result;
	}

	public Application findOne(final int applicationId) {
		Application result;

		result = this.applicationRepository.findOne(applicationId);

		return result;
	}

	public Application findOneToHacker(final int applicationId) {
		Application result;

		result = this.findOne(applicationId);

		Assert.notNull(result);
		Assert.isTrue(this.hackerService.findByPrincipal().equals(result.getHacker()));

		return result;
	}

	public Application findOneToCompany(final int applicationId) {
		Application result;

		result = this.findOne(applicationId);

		Assert.notNull(result);
		Assert.isTrue(this.companyService.findByPrincipal().equals(result.getPosition().getCompany()));

		return result;
	}

	public Collection<Application> findAll() {
		Collection<Application> results;

		results = this.applicationRepository.findAll();

		return results;
	}

	// Other business methods ---------------------

	public Problem getRandomProblem(final List<Problem> problems) {
		return problems.get(new Random().nextInt(problems.size()));
	}

	public Double[] findDataNumberApplicationPerHacker() {
		Double[] result;

		result = this.applicationRepository.findDataNumberApplicationPerHacker();
		Assert.notNull(result);

		return result;
	}

	protected Collection<Application> findApplicationsByProblemHacker(final int idProblem, final int idHacker) {
		Collection<Application> result;

		result = this.findApplicationsByProblemHacker(idProblem, idHacker);

		return result;
	}
}
