package org.openpaas.paasta.portal.api.service;

import org.openpaas.paasta.portal.api.common.Common;
import org.openpaas.paasta.portal.api.mapper.ConfigInfoMapper;
import org.openpaas.paasta.portal.api.model.ConfigInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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
public class ConfigInfoService extends Common {

//    private  static final Logger LOGGER = LoggerFactory.getLogger(ConfigInfoService.class);

    @Autowired
    private ConfigInfoMapper configInfoMapper;


    public List<ConfigInfo> getValue(ConfigInfo configInfo)  {

        return configInfoMapper.getValue(configInfo);

    }

    public void updateValue(ConfigInfo configInfo) {

        configInfoMapper.updateValue(configInfo);

    }

}
