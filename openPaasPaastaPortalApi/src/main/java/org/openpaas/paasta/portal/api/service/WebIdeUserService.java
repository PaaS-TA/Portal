package org.openpaas.paasta.portal.api.service;

import org.openpaas.paasta.portal.api.common.Common;
import org.openpaas.paasta.portal.api.mapper.AppAutoScaleModalMapper;
import org.openpaas.paasta.portal.api.mapper.WebIdeUserMapper;
import org.openpaas.paasta.portal.api.model.WebIdeUser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;

/**
 * Login Controller
 *
 * @author nawkm
 * @version 1.0
 * @since 2016.4.4 최초작성
 */
@Transactional
@Service
public class WebIdeUserService extends Common {

 //   private  static final Logger LOGGER = LoggerFactory.getLogger(WebIdeUserService.class);

    @Autowired
    private WebIdeUserMapper webIdeUserMapper;


    public WebIdeUser getUser(WebIdeUser webIdeUser)  {

        return webIdeUserMapper.getUser(webIdeUser);

    }

    public void insertUser(WebIdeUser webIdeUser) {

        webIdeUserMapper.insertUser(webIdeUser);

    }
    public void updateUser(WebIdeUser webIdeUser) {

        webIdeUserMapper.updateUser(webIdeUser);

    }

    public void deleteUser(WebIdeUser webIdeUser)  {

       webIdeUserMapper.deleteUser(webIdeUser);

    }

    public List<WebIdeUser> getList(WebIdeUser webIdeUser)  {

        return webIdeUserMapper.getList(webIdeUser);

    }

}
