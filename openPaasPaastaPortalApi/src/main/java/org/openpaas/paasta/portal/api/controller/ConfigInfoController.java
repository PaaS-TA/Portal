package org.openpaas.paasta.portal.api.controller;

import org.openpaas.paasta.portal.api.common.Common;
import org.openpaas.paasta.portal.api.common.Constants;
import org.openpaas.paasta.portal.api.model.ConfigInfo;
import org.openpaas.paasta.portal.api.service.ConfigInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.Map;

@RestController
@Transactional
@RequestMapping(value = {"/configInfo"})
public class ConfigInfoController extends Common {

    @Autowired
    private ConfigInfoService ConfigInfoService;

    @RequestMapping(value = {"/getValue"}, method = RequestMethod.POST)
    public Map<String, Object> getValue(@RequestBody ConfigInfo ConfigInfo) {

        Map<String, Object> resultMap = new HashMap<>();

        resultMap.put("list", ConfigInfoService.getValue(ConfigInfo));

        return resultMap;

    }

    @RequestMapping(value = {"/updateValue"}, method = RequestMethod.POST)
    public Map<String, Object> updateValue(@RequestBody ConfigInfo ConfigInfo) {

        Map<String, Object> resultMap = new HashMap<>();

        ConfigInfoService.updateValue(ConfigInfo);

        resultMap.put("RESULT", Constants.RESULT_STATUS_SUCCESS);

        return resultMap;
    }

}
