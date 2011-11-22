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
package org.telscenter.sail.webapp.dao.project.impl;

import java.util.List;

import net.sf.sail.webapp.dao.ObjectNotFoundException;
import net.sf.sail.webapp.dao.impl.AbstractHibernateDao;

import org.telscenter.sail.webapp.dao.project.TagDao;
import org.telscenter.sail.webapp.domain.project.Tag;
import org.telscenter.sail.webapp.domain.project.impl.TagImpl;

/**
 * @author patrick lawler
 * @version $Id:$
 */
public class HibernateTagDao extends AbstractHibernateDao<Tag> implements TagDao<Tag>{
	
	private static final String FIND_ALL_QUERY = "from TagImpl";

	@Override
	protected Class<? extends Tag> getDataObjectClass() {
		return TagImpl.class;
	}

	@Override
	protected String getFindAllQuery() {
		return HibernateTagDao.FIND_ALL_QUERY;
	}
	
	/**
	 * @see org.telscenter.sail.webapp.dao.project.TagDao#getTagByName(java.lang.String)
	 */
	@SuppressWarnings("unchecked")
	public Tag getTagByName(String name){
		List<Tag> tags = this.getHibernateTemplate().find("select tag from TagImpl tag where tag.name='" + name + "'");
		
		if(tags.size() == 0){
			return null;
		} else {
			return tags.get(0);
		}
	}
	
	/**
	 * 
	 * @param tagId
	 */
	@SuppressWarnings("unchecked")
	public void removeIfOrphaned(Long tagId){
		List<Tag> projects = this.getHibernateTemplate().find("select project from ProjectImpl project inner join project.tags tag where tag.id=" + tagId);
		
		if(projects.size() == 0){
			try{
				Tag tag = this.getById(tagId);
				this.delete(tag);
			} catch (ObjectNotFoundException e){
				e.printStackTrace();
			}
		}
	}
}
