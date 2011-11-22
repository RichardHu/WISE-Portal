/**
 * Copyright (c) 2008 Regents of the University of California (Regents). Created
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
package org.telscenter.sail.webapp.presentation.web.controllers.teacher.run.announcement;

import java.util.Calendar;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.validation.BindException;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.SimpleFormController;
import org.telscenter.sail.webapp.domain.announcement.Announcement;
import org.telscenter.sail.webapp.domain.impl.AnnouncementParameters;
import org.telscenter.sail.webapp.service.announcement.AnnouncementService;
import org.telscenter.sail.webapp.service.offering.RunService;

/**
 * @author patrick lawler
 * @version $Id:$
 */
public class EditAnnouncementController extends SimpleFormController{

	private AnnouncementService announcementService;
	
	private RunService runService;
	
	protected final static String ANNOUNCEMENTID = "announcementId";
	
	protected final static String RUNID = "runId";
	
	protected final static String RUN = "run";
	
	protected final static String SUCCESS = "teacher/run/announcement/manageannouncement";

	/**
	 * @see org.springframework.web.servlet.mvc.AbstractFormController#formBackingObject(javax.servlet.http.HttpServletRequest)
	 */
	@Override
	protected Object formBackingObject(HttpServletRequest request) throws Exception {
		Announcement announcement = announcementService.retrieveById(Long.parseLong(request.getParameter(ANNOUNCEMENTID)));
		AnnouncementParameters params = new AnnouncementParameters();
		params.setId(announcement.getId());
		params.setTimestamp(announcement.getTimestamp());
		params.setTitle(announcement.getTitle());
		params.setAnnouncement(announcement.getAnnouncement());
		params.setRunId(Long.parseLong(request.getParameter(RUNID)));
		return params;
	}
		
    @Override
    protected ModelAndView onSubmit(HttpServletRequest request,
            HttpServletResponse response, Object command, BindException errors) throws Exception{

    	AnnouncementParameters params = (AnnouncementParameters) command;
    	
    	announcementService.updateAnnouncement(params.getId(), params);
    	
    	ModelAndView modelAndView = new ModelAndView(SUCCESS);
    	modelAndView.addObject(RUNID, params.getRunId());
    	modelAndView.addObject(RUN, runService.retrieveById(params.getRunId()));
    	return modelAndView;
    }
    
	/**
	 * @param announcementService the announcementService to set
	 */
	public void setAnnouncementService(AnnouncementService announcementService) {
		this.announcementService = announcementService;
	}

	/**
	 * @param runService the runService to set
	 */
	public void setRunService(RunService runService) {
		this.runService = runService;
	}
}
