
package services;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.Assert;
import org.springframework.validation.BindingResult;
import org.springframework.validation.Validator;

import repositories.ProblemRepository;
import domain.Application;
import domain.Company;
import domain.Hacker;
import domain.Position;
import domain.Problem;

@Service
@Transactional
public class ProblemService {

	// Managed repository --------------------------

	@Autowired
	private ProblemRepository	problemRepository;

	// Other supporting services -------------------

	@Autowired
	private CompanyService		companyService;

	@Autowired
	private ApplicationService	applicationService;

	@Autowired
	private HackerService		hackerService;

	@Autowired
	private Validator			validator;


	// Constructors -------------------------------

	public ProblemService() {
		super();
	}

	// Simple CRUD methods ------------------------

	public Problem create() {
		Problem result;
		Company company;
		Collection<Position> positions;

		result = new Problem();
		company = this.companyService.findByPrincipal();
		positions = Collections.<Position> emptySet();

		result.setPositions(positions);
		result.setCompany(company);
		result.setIsFinalMode(false);

		return result;
	}

	public Problem save(final Problem problem) {
		Assert.notNull(problem);
		this.checkByPrincipal(problem);
		Assert.isTrue(!problem.getIsFinalMode());

		final Problem result;

		result = this.problemRepository.save(problem);

		return result;
	}

	public void delete(final Problem problem) {
		Assert.notNull(problem);
		Assert.isTrue(this.problemRepository.exists(problem.getId()));
		this.checkByPrincipal(problem);

		this.problemRepository.delete(problem);
	}

	public Problem findOneToEditDelete(final int problemId) {
		Problem result;

		result = this.problemRepository.findOne(problemId);
		this.checkByPrincipal(result);
		Assert.isTrue(!result.getIsFinalMode());

		Assert.notNull(result);

		return result;
	}

	public Problem findOne(final int problemId) {
		Problem result;

		result = this.problemRepository.findOne(problemId);
		Assert.notNull(result);

		return result;
	}

	public Problem findOneToPrincipal(final int problemId) {
		Problem result;

		result = this.problemRepository.findOne(problemId);
		this.checkByPrincipal(result);
		Assert.notNull(result);

		return result;
	}

	public Problem findOneToDisplayHacker(final int problemId) {
		Problem result;
		final Collection<Application> applicationsProblemHacker;
		Hacker principal;

		result = this.problemRepository.findOne(problemId);
		principal = this.hackerService.findByPrincipal();
		applicationsProblemHacker = this.applicationService.findApplicationsByProblemHacker(problemId, principal.getId());

		Assert.isTrue(!applicationsProblemHacker.isEmpty());
		Assert.notNull(result);

		return result;
	}

	public Collection<Problem> findProblemsByPrincipal() {
		final Collection<Problem> problems;
		Company principal;

		principal = this.companyService.findByPrincipal();
		problems = this.problemRepository.findByCompany(principal.getId());

		Assert.notNull(problems);

		return problems;
	}
	public void makeFinal(final Problem problem) {
		this.checkByPrincipal(problem);

		problem.setIsFinalMode(true);
	}

	public Collection<Problem> findProblemByPostion(final int positionId) {
		Collection<Problem> problems;

		problems = this.problemRepository.problemsPosition(positionId);

		return problems;
	}
	// This method id used when an actor want to delete all his or her data.
	public void deleteByCompany(final Company company) {
		Collection<Problem> problems;

		problems = this.problemRepository.findByCompany(company.getId());

		this.problemRepository.delete(problems);

	}

	private void checkByPrincipal(final Problem problem) {
		Company owner;
		Company principal;

		owner = problem.getCompany();
		principal = this.companyService.findByPrincipal();

		Assert.isTrue(owner.equals(principal));
	}

	// Protected methods-----------------------------------------------
	protected List<Problem> problemsPosition(final Position position) {
		List<Problem> problemsPosition;

		problemsPosition = new ArrayList<Problem>(this.problemRepository.problemsPosition(position.getId()));

		return problemsPosition;
	}

	// Reconstruct ----------------------------------------------
	public Problem reconstruct(final Problem problem, final BindingResult binding) {
		Problem result, problemStored;

		if (problem.getId() != 0) {
			result = new Problem();
			problemStored = this.findOne(problem.getId());
			result.setCompany(problemStored.getCompany());
			result.setIsFinalMode(problemStored.getIsFinalMode());
			result.setPositions(problemStored.getPositions());

		} else
			result = this.create();
		result.setId(problem.getId());
		result.setAttachments(problem.getAttachments());
		result.setHint(problem.getHint());
		result.setStatement(problem.getStatement());
		result.setTitle(problem.getTitle());

		this.validator.validate(result, binding);

		return result;
	}

}
