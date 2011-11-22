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
package org.telscenter.sail.webapp.presentation.web.filters;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;
import java.util.Calendar;
import java.util.Date;
import java.util.Properties;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.ServletException;
import javax.servlet.http.HttpSession;

import net.sf.sail.webapp.dao.ObjectNotFoundException;
import net.sf.sail.webapp.domain.User;
import net.sf.sail.webapp.presentation.web.filters.PasAuthenticationProcessingFilter;
import net.sf.sail.webapp.service.UserService;
import net.sf.sail.webapp.service.authentication.AuthorityNotFoundException;
import net.tanesha.recaptcha.ReCaptcha;
import net.tanesha.recaptcha.ReCaptchaFactory;
import net.tanesha.recaptcha.ReCaptchaImpl;
import net.tanesha.recaptcha.ReCaptchaResponse;

import org.springframework.context.ApplicationContext;
import org.springframework.security.Authentication;
import org.springframework.security.AuthenticationException;
import org.springframework.security.GrantedAuthority;
import org.springframework.security.ui.AbstractProcessingFilter;
import org.springframework.security.ui.savedrequest.SavedRequest;
import org.springframework.security.userdetails.UserDetails;
import org.springframework.util.StringUtils;
import org.springframework.web.context.support.WebApplicationContextUtils;
import org.telscenter.sail.webapp.domain.authentication.MutableUserDetails;
import org.telscenter.sail.webapp.domain.authentication.impl.StudentUserDetails;
import org.telscenter.sail.webapp.domain.authentication.impl.TeacherUserDetails;
import org.telscenter.sail.webapp.domain.portal.Portal;
import org.telscenter.sail.webapp.service.authentication.UserDetailsService;
import org.telscenter.sail.webapp.service.portal.PortalService;

/**
 * Custom AuthenticationProcessingFilter that subclasses Acegi Security. This
 * filter upon successful authentication will retrieve a <code>User</code> and
 * put it into the http session.
 *
 * @author Hiroki Terashima
 * @version $Id$
 */
public class TelsAuthenticationProcessingFilter extends
		PasAuthenticationProcessingFilter {

	public static final String STUDENT_DEFAULT_TARGET_PATH = "/student/index.html";
	//private static final String STUDENT_DEFAULT_TARGET_PATH = "/student/vle/vle.html?runId=65";
	public static final String TEACHER_DEFAULT_TARGET_PATH = "/teacher/index.html";
	public static final String ADMIN_DEFAULT_TARGET_PATH = "/admin/index.html";
	public static final String RESEARCHER_DEFAULT_TARGET_PATH = "/teacher/index.html";
	public static final String LOGOUT_PATH = "pages/wiselogout.html";

	public static final Integer recentFailedLoginTimeLimit = 15;
	public static final Integer recentFailedLoginAttemptsLimit = 5;
	
	private UserDetailsService userDetailsService;
	
	private PortalService portalService;
	
	private Properties portalProperties;
	
	/**
	 * @see org.acegisecurity.ui.AbstractProcessingFilter#successfulAuthentication(javax.servlet.http.HttpServletRequest,
	 *      javax.servlet.http.HttpServletResponse,
	 *      org.acegisecurity.Authentication)
	 */
	@Override
	protected void successfulAuthentication(
			javax.servlet.http.HttpServletRequest request,
			javax.servlet.http.HttpServletResponse response,
			Authentication authResult) throws IOException, ServletException {
		
        UserDetails userDetails = (UserDetails) authResult.getPrincipal();
        boolean userIsAdmin = false;
        if (userDetails instanceof StudentUserDetails) {        	
        	// pLT= previous login time (not this time, but last time)
        	Date lastLoginTime = ((StudentUserDetails) userDetails).getLastLoginTime();
        	long pLT = 0L; // previous last log in time
        	if (lastLoginTime != null) {
        		pLT = lastLoginTime.getTime();
        	}
        	this.setDefaultTargetUrl(STUDENT_DEFAULT_TARGET_PATH + "?pLT=" + pLT);                	
        }
        else if (userDetails instanceof TeacherUserDetails) {
	   		this.setDefaultTargetUrl(TEACHER_DEFAULT_TARGET_PATH);

        	GrantedAuthority researcherAuth = null;
        	try {
        		researcherAuth = userDetailsService.loadAuthorityByName(UserDetailsService.RESEARCHER_ROLE);
			} catch (AuthorityNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			GrantedAuthority authorities[] = userDetails.getAuthorities();
        	for (int i = 0; i < authorities.length; i++) {
        		if (researcherAuth.equals(authorities[i])) {
        			this.setDefaultTargetUrl(RESEARCHER_DEFAULT_TARGET_PATH);
        		}
        	}
	   		
        	GrantedAuthority adminAuth = null;
        	try {
				adminAuth = userDetailsService.loadAuthorityByName(UserDetailsService.ADMIN_ROLE);
			} catch (AuthorityNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
        	for (int i = 0; i < authorities.length; i++) {
        		if (adminAuth.equals(authorities[i])) {
        			this.setDefaultTargetUrl(ADMIN_DEFAULT_TARGET_PATH);
        			userIsAdmin = true;
        		}
        	}
        }
        
        // if user is not admin and login is disallowed, redirect user to logout page
        try {
			Portal portal = portalService.getById(0);
			if (!userIsAdmin && !portal.isLoginAllowed()) {
		        	response.sendRedirect(LOGOUT_PATH);
		        	return;
		    }
        } catch (ObjectNotFoundException e) {
		}  
      
        /* redirect if specified in the login request */
   		String redirectUrl = request.getParameter("redirect");
   		if(StringUtils.hasText(redirectUrl)){
   			this.setDefaultTargetUrl(redirectUrl);
   		}
   		
   		HttpSession session = request.getSession();
		ApplicationContext springContext = WebApplicationContextUtils.getWebApplicationContext(session.getServletContext());
		UserService userService = (UserService) springContext.getBean("userService");
		
		//get the saved request, if any
		SavedRequest savedRequest = (SavedRequest) session.getAttribute(AbstractProcessingFilter.SPRING_SECURITY_SAVED_REQUEST_KEY);
		
		if(savedRequest != null) {
			//get whether the saved request was a POST or GET
			String method = savedRequest.getMethod();
			
			if(method != null && method.equals("POST")) {
				//request was a POST so we can ignore it by setting the saved request value to null
				session.setAttribute(AbstractProcessingFilter.SPRING_SECURITY_SAVED_REQUEST_KEY, null);
			} else if (method != null && method.equals("GET")) {
				// if a teacher logs in and is going to student home page, redirect them to teacher home page
				 if (userDetails instanceof TeacherUserDetails && savedRequest.getRequestURL().contains(STUDENT_DEFAULT_TARGET_PATH)) {
					 session.setAttribute(AbstractProcessingFilter.SPRING_SECURITY_SAVED_REQUEST_KEY, null);					 
				 }
			}
		}

   		//get the user
		User user = userService.retrieveUser(userDetails);
		session.setAttribute(User.CURRENT_USER_SESSION_KEY, user);
		
		//get the public and private keys from the portal.properties
		String reCaptchaPublicKey = portalProperties.getProperty("recaptcha_public_key");
		String reCaptchaPrivateKey = portalProperties.getProperty("recaptcha_private_key");
		
		//check if the public key is valid in case the admin entered it wrong
		boolean reCaptchaKeyValid = isReCaptchaKeyValid(reCaptchaPublicKey, reCaptchaPrivateKey);
		
		/*
		 * get the user so we can check if they have been failing to login
		 * multiple times recently and if so, we will display a captcha to
		 * make sure they are not a bot. the public and private keys must be set in
		 * the portal.properties otherwise we will not use captcha at all. we
		 * will also check to make sure the captcha keys are valid otherwise
		 * we won't use the captcha at all either.
		 */
		if(user != null && reCaptchaPrivateKey != null && reCaptchaPublicKey != null && reCaptchaKeyValid) {
			//get the user details
			MutableUserDetails mutableUserDetails = (MutableUserDetails) user.getUserDetails();

			//get the current time
			Date currentTime = new Date();

			//get the recent time they failed to log in
			Date recentFailedLoginTime = mutableUserDetails.getRecentFailedLoginTime();

			if(recentFailedLoginTime != null) {
				//get the time difference
				long timeDifference = currentTime.getTime() - recentFailedLoginTime.getTime();

				//check if the time difference is less than 15 minutes
				if(timeDifference < (recentFailedLoginTimeLimit * 60 * 1000)) {
					//get the number of failed login attempts since recentFailedLoginTime
					Integer numberOfRecentFailedLoginAttempts = mutableUserDetails.getNumberOfRecentFailedLoginAttempts();

					//check if the user failed to log in 5 or more times
					if(numberOfRecentFailedLoginAttempts != null &&
							numberOfRecentFailedLoginAttempts >= recentFailedLoginAttemptsLimit) {

						/*
						 * the user has failed to log in 5 or more times in the last 15 minutes
						 * so they need to fill in the captcha
						 */
						String reCaptchaChallengeField = request.getParameter("recaptcha_challenge_field");
						String reCaptchaResponseField = request.getParameter("recaptcha_response_field");
						String remoteAddr = request.getRemoteAddr();

						if(reCaptchaChallengeField != null && reCaptchaResponseField != null && remoteAddr != null) {
							//the user filled in the captcha

							ReCaptchaImpl reCaptcha = new ReCaptchaImpl();
							reCaptcha.setPrivateKey(reCaptchaPrivateKey);
							ReCaptchaResponse reCaptchaResponse = reCaptcha.checkAnswer(remoteAddr, reCaptchaChallengeField, reCaptchaResponseField);

							if (!reCaptchaResponse.isValid()) {
								/*
								 * user did not correctly answer the captcha so we will
								 * redirect them to the failure page
								 */
								unsuccessfulAuthentication(request, response, new AuthenticationException(remoteAddr, mutableUserDetails) {});

								return;
							}
						} else {
							/*
							 * there are no captcha params because the user was on the index.html
							 * page where the captcha does not show up. we will redirect them to
							 * the login.html page and require the captcha.
							 * 
							 * note: if the user has failed to log in 5 or more times in the last
							 * 15 minutes, we will require them to fill in the captcha. if at that
							 * point, the user tries to log in from the index.html page (which does
							 * not display the captcha) and correctly enters their 
							 * username and password, we will still not allow them
							 * to log in. we will redirect them to the login.html page and require
							 * the captcha. this is to prevent the user/bot from always just accessing
							 * the index.html page to try to log in order to circumvent the captcha.
							 */
							AuthenticationException authenticationException = new AuthenticationException(remoteAddr, mutableUserDetails) {};
							unsuccessfulAuthentication(request, response, authenticationException);

							return;
						}
					}        		
				}
			}
		}
   		
		super.successfulAuthentication(request, response, authResult);
		((MutableUserDetails) userDetails).incrementNumberOfLogins();
		((MutableUserDetails) userDetails).setLastLoginTime(Calendar.getInstance().getTime());
		((MutableUserDetails) userDetails).setNumberOfRecentFailedLoginAttempts(0);
		userDetailsService.updateUserDetails((MutableUserDetails) userDetails);
       
	}
	
	/**
	 * Called when the user fails to log in to the portal. This function updates
	 * the recent failed login time and recent failed number of attempts.
	 * @see org.springframework.security.ui.AbstractProcessingFilter#unsuccessfulAuthentication(javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse, org.springframework.security.AuthenticationException)
	 */
	@Override
	protected void unsuccessfulAuthentication(
			javax.servlet.http.HttpServletRequest request, 
			javax.servlet.http.HttpServletResponse response, 
			AuthenticationException failed) throws IOException, ServletException {

		Authentication authentication = failed.getAuthentication();

		String userName = "";

		if(authentication != null) {
			//get the user name from the authentication
			userName = (String) authentication.getPrincipal();
		} else {
			/*
			 * the authentication is null which means the user failed to answer
			 * the captcha correctly. if this is the case, this function is being
			 * called from successfulAuthentication() 
			 */
			Object extraInformation = failed.getExtraInformation();

			if(extraInformation instanceof MutableUserDetails) {
				//get the user name from the MutableUserDetails
				MutableUserDetails extraInformationUserDetails = (MutableUserDetails) extraInformation;
				userName = extraInformationUserDetails.getUsername();
			}
		}

		HttpSession session = request.getSession();
		ApplicationContext springContext = WebApplicationContextUtils.getWebApplicationContext(session.getServletContext());
		UserService userService = (UserService) springContext.getBean("userService");

		//get the user
		User user = userService.retrieveUserByUsername(userName);
		
		if(user != null) {
			//user name exists

			//get the user details
			MutableUserDetails userDetails = (MutableUserDetails) user.getUserDetails();

			//get the recent time they failed to login
			Date recentFailedLoginTime = userDetails.getRecentFailedLoginTime();

			//get the current time
			Date currentTime = new Date();

			if(recentFailedLoginTime != null) {
				//they have failed to log in before

				long timeDifference = currentTime.getTime() - recentFailedLoginTime.getTime();

				/*
				 * check if the time difference is less than 15 minutes. if the time difference
				 * is less than 15 minutes we will increment the failed attempts counter.
				 * if the difference is greater than 15 minutes we will reset the counter.
				 */
				if(timeDifference < (recentFailedLoginTimeLimit * 60 * 1000)) {
					//time since last failed attempt is less than 15 minutes

					//increase the recent failed number of attempts by 1
					userDetails.incrementNumberOfRecentFailedLoginAttempts();
				} else {
					//time since last failed attempt is greater than 15 minutes

					//set the time they failed to log in
					userDetails.setRecentFailedLoginTime(currentTime);

					//set the failed number of attempts
					userDetails.setNumberOfRecentFailedLoginAttempts(1);
				}
			} else {
				//they have never failed to log in

				//set the time they failed to log in
				userDetails.setRecentFailedLoginTime(currentTime);

				//set the failed number of attempts
				userDetails.setNumberOfRecentFailedLoginAttempts(1);
			}

			//update the user
			userService.updateUser(user);
		}

		super.unsuccessfulAuthentication(request, response, failed);
	}

	/**
	 * Get the failure url. This function checks if the public and private 
	 * keys for the captcha have been provided and if the user has failed
	 * to log in 5 or more times in the last 15 minutes. If so, it will
	 * require the failure url page to display a captcha.
	 * @see org.springframework.security.ui.AbstractProcessingFilter#determineFailureUrl(javax.servlet.http.HttpServletRequest, org.springframework.security.AuthenticationException)
	 */
	@Override
	protected String determineFailureUrl(javax.servlet.http.HttpServletRequest request, AuthenticationException failed) {
		String authenticationFailureUrl = getAuthenticationFailureUrl();

		//check if the public and private keys are set in the portal.properties
		String reCaptchaPublicKey = portalProperties.getProperty("recaptcha_public_key");
		String reCaptchaPrivateKey = portalProperties.getProperty("recaptcha_private_key");

		//check if the public key is valid in case the admin entered it wrong
		boolean reCaptchaKeyValid = isReCaptchaKeyValid(reCaptchaPublicKey, reCaptchaPrivateKey);
		
		if(reCaptchaPublicKey != null && reCaptchaPrivateKey != null && reCaptchaKeyValid) {
			/*
			 * the public and private keys for the captcha have been provided and
			 * the public key is valid so now we will check if the user has failed
			 * to log in 5 or more times in the last 15 minutes.
			 */
			
			Authentication authentication = failed.getAuthentication();

			String userName = "";

			if(authentication != null) {
				//get the user name from the authentication
				userName = (String) authentication.getPrincipal();
			} else {
				Object extraInformation = failed.getExtraInformation();
				if(extraInformation instanceof MutableUserDetails) {
					//get the user name from the MutableUserDetails
					MutableUserDetails extraInformationUserDetails = (MutableUserDetails) extraInformation;
					userName = extraInformationUserDetails.getUsername();    			
				}
			}

			HttpSession session = request.getSession();
			ApplicationContext springContext = WebApplicationContextUtils.getWebApplicationContext(session.getServletContext());
			UserService userService = (UserService) springContext.getBean("userService");

			//get the user
			User user = userService.retrieveUserByUsername(userName);

			if(user != null) {
				//user exists

				//get the user details
				MutableUserDetails userDetails = (MutableUserDetails) user.getUserDetails();

				Integer numberOfRecentFailedLoginAttempts = userDetails.getNumberOfRecentFailedLoginAttempts();

				if(numberOfRecentFailedLoginAttempts != null && 
						userDetails.getNumberOfRecentFailedLoginAttempts() >= recentFailedLoginAttemptsLimit) {
					/*
					 * the user has failed to login 5 or more times in the last
					 * 15 minutes so we will require them to fill in a captcha
					 */
					authenticationFailureUrl += "&requireCaptcha=true";
				}
			}			
		}

		return authenticationFailureUrl;
	}
	
	/**
	 * Check to make sure the public key is valid. We can only check if the public
	 * key is valid. If the private key is invalid the admin will have to realize that.
	 * We also check to make sure the connection to the captcha server is working.
	 * @param reCaptchaPublicKey the public key
	 * @param recaptchaPrivateKey the private key
	 * @return whether the captcha is valid and should be used
	 */
	private boolean isReCaptchaKeyValid(String reCaptchaPublicKey, String recaptchaPrivateKey) {
		boolean isValid = false;
		
		if(reCaptchaPublicKey != null && recaptchaPrivateKey != null) {
			
			//make a new instace of the captcha so we can make sure th key is valid
			ReCaptcha c = ReCaptchaFactory.newReCaptcha(reCaptchaPublicKey, recaptchaPrivateKey, false);
			
			/*
			 * get the html that will display the captcha
			 * e.g.
			 * <script type="text/javascript" src="http://api.recaptcha.net/challenge?k=yourpublickey"></script>
			 */
			String recaptchaHtml = c.createRecaptchaHtml(null, null);
			
			/*
			 * try to retrieve the src url by matching everything between the
			 * quotes of src=""
			 * 
			 * e.g. http://api.recaptcha.net/challenge?k=yourpublickey
			 */
			Pattern pattern = Pattern.compile(".*src=\"(.*)\".*");
			Matcher matcher = pattern.matcher(recaptchaHtml);
			matcher.find();
			String match = matcher.group(1);
			
			try {
				/*
				 * get the response text from the url
				 */
				
				URL url = new URL(match);
		        URLConnection urlConnection = url.openConnection();
		        BufferedReader in = new BufferedReader(new InputStreamReader(urlConnection.getInputStream()));
		        
		        StringBuffer text = new StringBuffer();
		        String inputLine;

		        while ((inputLine = in.readLine()) != null) {
		            text.append(inputLine);
		        }
		        in.close();
		        
		        //the response text from the url
		        String responseText = text.toString();

		        /*
		         * if the public key was invalid the text returned from the url will
		         * look like
		         * 
		         * document.write('Input error: k: Format of site key was invalid\n');
		         */
		        if(!responseText.contains("Input error")) {
		        	//the text from the server does not contain the error so the key is valid
		        	isValid = true;
		        }
			} catch (MalformedURLException e) {
				/*
				 * if there was a problem connecting to the server this function will return
				 * false so that users can still log in and won't be stuck because the
				 * recaptcha server is down.
				 */
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}

        return isValid;
	}

	/**
	 * @return the userDetailsService
	 */
	public UserDetailsService getUserDetailsService() {
		return userDetailsService;
	}

	/**
	 * @param userDetailsService the userDetailsService to set
	 */
	public void setUserDetailsService(UserDetailsService userDetailsService) {
		this.userDetailsService = userDetailsService;
	}

	/**
	 * @param portalService the portalService to set
	 */
	public void setPortalService(PortalService portalService) {
		this.portalService = portalService;
	}		

	/**
	 * 
	 * @return
	 */
	public Properties getPortalProperties() {
		return portalProperties;
	}

	/**
	 * 
	 * @param portalProperties
	 */
	public void setPortalProperties(Properties portalProperties) {
		this.portalProperties = portalProperties;
	}
}