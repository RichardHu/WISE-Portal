/**
 * Copyright (c) 2007 Regents of the University of California (Regents). Created
 * by TELS, Graduate School of Education, University of California at Berkeley.
 *
 * This software is distributed under the GNU Lesser General Public License, v2.
 *
 * Permission is hereby granted, without written agreement and without license
 * or royalty fees, to use, copy, modify, and distribute this software and its
 * documentation for any purpose, provided that the above copyright notice and
 * the following two paragraphs appear in all copies of this software.
 *
 * REGENTS SPECIFICALLY DISCLAIMS ANY WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
 * THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
 * PURPOSE. THE SOFTWAREAND ACCOMPANYING DOCUMENTATION, IF ANY, PROVIDED
 * HEREUNDER IS PROVIDED "AS IS". REGENTS HAS NO OBLIGATION TO PROVIDE
 * MAINTENANCE, SUPPORT, UPDATES, ENHANCEMENTS, OR MODIFICATIONS.
 *
 * IN NO EVENT SHALL REGENTS BE LIABLE TO ANY PARTY FOR DIRECT, INDIRECT,
 * SPECIAL, INCIDENTAL, OR CONSEQUENTIAL DAMAGES, INCLUDING LOST PROFITS,
 * ARISING OUT OF THE USE OF THIS SOFTWARE AND ITS DOCUMENTATION, EVEN IF
 * REGENTS HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */
package org.telscenter.sail.webapp.presentation.web.controllers.student;

import java.util.Date;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.sail.webapp.domain.User;
import net.sf.sail.webapp.domain.Workgroup;
import net.sf.sail.webapp.domain.group.Group;
import net.sf.sail.webapp.domain.webservice.http.HttpRestTransport;
import net.sf.sail.webapp.presentation.web.controllers.ControllerUtil;
import net.sf.sail.webapp.service.UserService;

import org.springframework.validation.BindException;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.SimpleFormController;
import org.springframework.web.servlet.view.RedirectView;
import org.telscenter.sail.webapp.domain.Run;
import org.telscenter.sail.webapp.domain.StudentUserAlreadyAssociatedWithRunException;
import org.telscenter.sail.webapp.domain.impl.Projectcode;
import org.telscenter.sail.webapp.domain.project.impl.LaunchProjectParameters;
import org.telscenter.sail.webapp.domain.run.StudentRunInfo;
import org.telscenter.sail.webapp.domain.workgroup.WISEWorkgroup;
import org.telscenter.sail.webapp.presentation.util.json.JSONArray;
import org.telscenter.sail.webapp.presentation.web.TeamSignInForm;
import org.telscenter.sail.webapp.service.attendance.StudentAttendanceService;
import org.telscenter.sail.webapp.service.offering.RunService;
import org.telscenter.sail.webapp.service.project.ProjectService;
import org.telscenter.sail.webapp.service.student.StudentService;
import org.telscenter.sail.webapp.service.workgroup.WISEWorkgroupService;

/**
 * Controller for handling team sign-ins before students start the project. The first user
 * entered in the form must be already signed-in and associated with a specific
 * <code>Run</code> and specific period. The second and third users entered will be
 * associated with the same <code>Run</code> and same period as the first user if
 * they are not already associated.
 *
 * @author Hiroki Terashima
 * @version $Id$
 */
public class TeamSignInController extends SimpleFormController {

	private UserService userService;
	
	private WISEWorkgroupService workgroupService;
	
	private RunService runService;
	
	private StudentService studentService;

	private ProjectService projectService;

	private HttpRestTransport httpRestTransport;
	
	private StudentAttendanceService studentAttendanceService;

	public TeamSignInController() {
		setSessionForm(true);
	}
	
	/**
	 * On submission of the Team Sign In form, the workgroup is updated
	 * Assume that the usernames are valid usernames that exist in the data store
	 * 
	 * @see org.springframework.web.servlet.mvc.SimpleFormController#onSubmit(javax.servlet.http.HttpServletRequest,
	 *      javax.servlet.http.HttpServletResponse, java.lang.Object,
	 *      org.springframework.validation.BindException)
	 */
	@Override
	protected synchronized ModelAndView onSubmit(HttpServletRequest request,
			HttpServletResponse response, Object command, BindException errors)
	throws Exception {
		//the arrays to store the user ids of the students that are present or absent
		JSONArray presentUserIds = new JSONArray();
		JSONArray absentUserIds = new JSONArray();
		
		TeamSignInForm teamSignInForm = (TeamSignInForm) command;
		User user1 = userService.retrieveUserByUsername(teamSignInForm.getUsername1());
		User user2 = userService.retrieveUserByUsername(teamSignInForm.getUsername2());
		User user3 = userService.retrieveUserByUsername(teamSignInForm.getUsername3());
		
		Run run = runService.retrieveById(teamSignInForm.getRunId());
		
		// get projectcode to use to add user2 and user3 to run
		StudentRunInfo studentRunInfoUser1 = studentService.getStudentRunInfo(user1, run);
		Projectcode projectcode = new Projectcode(run.getRuncode(), studentRunInfoUser1.getGroup().getName());

		//stores the members that are logged in
		Set<User> membersLoggedIn = new HashSet<User>();
		String workgroupname = "Workgroup for " + user1.getUserDetails().getUsername();
		
		//add the user that is already logged in
		membersLoggedIn.add(user1);
		
		//add user1 to the users that are present
		presentUserIds.put(user1.getId());
		
		/*
		 * get the workgroups for this run for user1, they should
		 * usually only be in 1 workgroup
		 */
		List<Workgroup> workgroups = workgroupService.getWorkgroupListByOfferingAndUser(run, user1);

		//get the members in the workgroup
		Set<User> membersInWorkgroup = new HashSet<User>();
		
		if(workgroups != null && workgroups.size() > 0) {
			//get the members in the workgroup
			membersInWorkgroup = workgroups.get(0).getMembers();
		}
		
		if (user2 != null) {
			try {
				studentService.addStudentToRun(user2, projectcode);
			} catch (StudentUserAlreadyAssociatedWithRunException e) {
				// do nothing. it's okay if the student is already associated with this run.
			}
			
			//add user2 to the members logged in
			membersLoggedIn.add(user2);
			
			workgroupname += user2.getUserDetails().getUsername();
			workgroups.addAll(workgroupService.getWorkgroupListByOfferingAndUser(run, user2));
			
			//add user2 to the users that are present
			presentUserIds.put(user2.getId());
		}
		if (user3 != null) {
			try {
				studentService.addStudentToRun(user3, projectcode);
			} catch (StudentUserAlreadyAssociatedWithRunException e) {
				// do nothing. it's okay if the student is already associated with this run.
			}
			
			//add user3 to the members logged in
			membersLoggedIn.add(user3);
			
			workgroupname += user3.getUserDetails().getUsername();
			workgroups.addAll(workgroupService.getWorkgroupListByOfferingAndUser(run, user3));
			
			//add user3 to the users that are present
			presentUserIds.put(user3.getId());
		}

		Workgroup workgroup = null;
		Group period = run.getPeriodOfStudent(user1);
		if (workgroups.size() == 0) {
			workgroup = workgroupService.createWISEWorkgroup(workgroupname, membersLoggedIn, run, period);
		} else if (workgroups.size() == 1) {
			workgroup = workgroups.get(0);
			workgroupService.addMembers(workgroup, membersLoggedIn);
		} else {
			// more than one user has created a workgroup for this run.
			// TODO HT gather requirements and find out what should be done in this case
			// for now, just choose one
			workgroup = workgroups.get(0);
			workgroupService.addMembers(workgroup, membersLoggedIn);
		}
		
		/*
		 * loop through all the members that are in the workgroup to
		 * see who is absent
		 */
		Iterator<User> membersInWorkgroupIter = membersInWorkgroup.iterator();
		while(membersInWorkgroupIter.hasNext()) {
			boolean memberLoggedIn = false;
			
			//get a user that is in the workgroup
			User memberInWorkgroup = membersInWorkgroupIter.next();
			
			/*
			 * check if the user has logged in and is present
			 * by looping through all the user ids in presentUserIds
			 * and seeing if the user id is in the presentUserIds
			 * array
			 */
			for(int x=0; x<presentUserIds.length(); x++) {
				//get a present user id
				long presentUserId = presentUserIds.getLong(x);
				
				if(presentUserId == memberInWorkgroup.getId()) {
					//the user id matches so this memberInWorkgroup is present
					memberLoggedIn = true;
					break;
				}
			}
			
			if(!memberLoggedIn) {
				//the memberInWorkgroup is absent
				absentUserIds.put(memberInWorkgroup.getId());
			}
		}
		
		//get the values to create the student attendance entry
		Long workgroupId = workgroup.getId();
		Long runId = run.getId();
		Date loginTimestamp = new Date();
		
		//create a student attendance entry
		this.studentAttendanceService.addStudentAttendanceEntry(workgroupId, runId, loginTimestamp, presentUserIds.toString(), absentUserIds.toString());
		
		ModelAndView modelAndView = new ModelAndView();
		
		/* update run statistics */
		this.runService.updateRunStatistics(run.getId());
		
		LaunchProjectParameters launchProjectParameters = new LaunchProjectParameters();
		launchProjectParameters.setRun(run);
		launchProjectParameters.setWorkgroup((WISEWorkgroup) workgroup);
		launchProjectParameters.setHttpRestTransport(this.httpRestTransport);
		launchProjectParameters.setHttpServletRequest(request);
		StartProjectController.notifyServletSession(request, run);
		modelAndView = (ModelAndView) projectService.launchProject(launchProjectParameters);
		modelAndView.addObject("closeokay", true);
		
		return modelAndView;
	}
	
	@Override
	protected Object formBackingObject(HttpServletRequest request) throws Exception {
		//get the signed in username
		User user = ControllerUtil.getSignedInUser();
		String signedInUsername = user.getUserDetails().getUsername();
		
		//get the form
		TeamSignInForm form = new TeamSignInForm();
		Long runId = null;
		
		//set the signed in username
		form.setUsername1(signedInUsername);
		
		try {
			//get the run id
			String runIdString = request.getParameter("runId");
			runId = Long.valueOf(runIdString);
		} catch (NumberFormatException e) {
			// do nothing.
		}
		
		if(runId != null) {
			//set the run id
			form.setRunId(runId);
			
			//get the run
			Run run = (Run) runService.getOffering(runId);
			
			//get the members in the workgroup
			StudentRunInfo studentRunInfo = studentService.getStudentRunInfo(user, run);
			
			/*
			 * try to get the workgroup if it exists. if the student is running
			 * the project for the first time, the workgroup will not exist
			 */
			Workgroup workgroup = studentRunInfo.getWorkgroup();
			
			if(workgroup != null) {
				//get the members in the workgroup and pre-populate the username fields
				Set<User> members = workgroup.getMembers();

				//counter for how many members we have so far
				int currentNumMembers = 1;
				
				//loop through all the members
				Iterator<User> membersIterator = members.iterator();
				while(membersIterator.hasNext()) {
					//get a member and their username
					User member = membersIterator.next();
					String username = member.getUserDetails().getUsername();
					
					//check that the username is not the one that is already signed in
					if(username != null && !username.equals(signedInUsername)) {
						if(currentNumMembers == 1) {
							//set the username2
							form.setUsername2(username);
							currentNumMembers++;
						} else if(currentNumMembers == 2) {
							//set the username3
							form.setUsername3(username);
							currentNumMembers++;
						}				
					}
				}					
			}
		}
		
		return form;
	}
	
	@Override
	protected final ModelAndView showForm(HttpServletRequest request,
            HttpServletResponse response,
            BindException errors)
     throws Exception {
		// check to see if the logged-in user is associated with the runId or not before showing the sign in form.
		try {
			Long runId = Long.valueOf(request.getParameter("runId"));
			Run run = runService.retrieveById(runId);
			User signedInUser = ControllerUtil.getSignedInUser();
			if (run.isStudentAssociatedToThisRun(signedInUser)) {
				return super.showForm(request, response, errors);			
			} else {
				return new ModelAndView(new RedirectView("index.html"));
			}
		} catch (NumberFormatException nfe) {
			// if there was an error (e.g. runId=abc or no runId specified, redirect to student homepage.
			return new ModelAndView(new RedirectView("index.html"));			
		}		
	}

	/**
	 * @param userService the userService to set
	 */
	public void setUserService(UserService userService) {
		this.userService = userService;
	}

	/**
	 * @param workgroupService the workgroupService to set
	 */
	public void setWorkgroupService(WISEWorkgroupService workgroupService) {
		this.workgroupService = workgroupService;
	}

	/**
	 * @param runService the runService to set
	 */
	public void setRunService(RunService runService) {
		this.runService = runService;
	}

	/**
	 * @param studentService the studentService to set
	 */
	public void setStudentService(StudentService studentService) {
		this.studentService = studentService;
	}

	/**
	 * @param httpRestTransport the httpRestTransport to set
	 */
	public void setHttpRestTransport(HttpRestTransport httpRestTransport) {
		this.httpRestTransport = httpRestTransport;
	}

	/**
	 * @param projectService the projectService to set
	 */
	public void setProjectService(ProjectService projectService) {
		this.projectService = projectService;
	}

	/**
	 * 
	 * @return
	 */
	public StudentAttendanceService getStudentAttendanceService() {
		return studentAttendanceService;
	}

	/**
	 * 
	 * @param studentAttendanceService
	 */
	public void setStudentAttendanceService(
			StudentAttendanceService studentAttendanceService) {
		this.studentAttendanceService = studentAttendanceService;
	}
}
