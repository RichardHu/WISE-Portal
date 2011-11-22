/**
 * Copyright (c) 2007 Encore Research Group, University of Toronto
 * 
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
 */
package net.sf.sail.webapp.presentation.web.controllers;

import org.junit.runner.RunWith;
import org.junit.runners.Suite;

/**
 * @author Cynick Young
 *
 * @version $Id$
 *
 */
@RunWith(Suite.class)
@Suite.SuiteClasses( {
	net.sf.sail.webapp.presentation.web.controllers.groups.AddgroupControllerTest.class,
	//net.sf.sail.webapp.presentation.web.controllers.groups.EditGroupControllerTest.class,  TODO HIROKI uncomment me when submitting
	net.sf.sail.webapp.presentation.web.controllers.offerings.CreateOfferingControllerTest.class,
	net.sf.sail.webapp.presentation.web.controllers.offerings.OfferingListControllerTest.class,
	net.sf.sail.webapp.presentation.web.controllers.LoginControllerTest.class,
	net.sf.sail.webapp.presentation.web.controllers.SignupControllerTest.class,
	net.sf.sail.webapp.presentation.web.controllers.ChangePasswordControllerTest.class
})

public class AllTests {
}
