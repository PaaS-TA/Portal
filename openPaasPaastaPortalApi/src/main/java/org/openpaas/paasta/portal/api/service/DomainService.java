package org.openpaas.paasta.portal.api.service;

import org.cloudfoundry.client.lib.CloudFoundryClient;
import org.cloudfoundry.client.lib.CloudFoundryException;
import org.cloudfoundry.client.lib.domain.CloudDomain;
import org.openpaas.paasta.portal.api.common.Common;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by Dojun on 2016-07-25.
 */
@Service
public class DomainService extends Common {

    private static final Logger LOGGER = LoggerFactory.getLogger(DomainService.class);


    /**
     * 도메인 가져오기 - status 값을 받아 private, shared 중 선택하여 가져오거나 모두 가져올수 있음
     *
     * @author kimdojun
     * @since 2016.7.25 최초작성
     * @param token
     * @param status
     * @return
     * @throws Exception
     */
    public List<CloudDomain> getDomains(String token, String status) throws Exception {

        LOGGER.info("Start getDomains service. status : "+status);
        List<CloudDomain> domains;
        CloudFoundryClient client = getCloudFoundryClient(token);

        if(!stringNullCheck(status)){
            throw new CloudFoundryException(HttpStatus.BAD_REQUEST,"Bad Request","Invalid status");
        } else {
            switch (status){
                case "all":
                    domains = client.getDomains();
                    break;
                case "private":
                    domains = client.getPrivateDomains();
                    break;
                case "shared":
                    domains = client.getSharedDomains();
                    break;
                default:
                    throw new CloudFoundryException(HttpStatus.BAD_REQUEST,"Bad Request","Invalid status");
            }
        }

        LOGGER.info("End getDomains service. status : "+status);

        return domains;
    }

    /**
     * 도메인 추가
     *
     * @author kimdojun
     * @since 2016.7.25 최초작성
     * @param token
     * @param orgName
     * @param spaceName
     * @param domainName
     * @return Boolean
     * @throws Exception
     */
    public boolean addDomain(String token, String orgName, String spaceName, String domainName) throws Exception {
        LOGGER.info("Start addDomain service. domainName : "+domainName);

        if (!stringNullCheck(orgName,spaceName,domainName)) {
            throw new CloudFoundryException(HttpStatus.BAD_REQUEST,"Bad Request","Required request body content is missing");
        }

        CloudFoundryClient client = getCloudFoundryClient(token,orgName,spaceName);


        if(client.getDomains().stream().anyMatch(domain -> domain.getName().equals(domainName))){
            throw new CloudFoundryException(HttpStatus.CONFLICT,"Conflict","Domain name already exist.");
        }

        client.addDomain(domainName);

        LOGGER.info("End addDomain service. domainName : "+domainName);
        return true;
    }


    /**
     *
     * 도메인 삭제
     *
     * @author kimdojun
     * @since 2016.7.25 최초작성
     * @param token
     * @param orgName
     * @param spaceName
     * @param domainName
     * @return Boolean
     * @throws Exception
     */
    public boolean deleteDomain(String token, String orgName, String spaceName, String domainName) throws Exception {
        LOGGER.info("Start deleteDomain service. domainName : "+domainName);

        if (!stringNullCheck(orgName,spaceName,domainName)) {
            throw new CloudFoundryException(HttpStatus.BAD_REQUEST,"Bad Request","Required request body content is missing");
        }

        CloudFoundryClient client = getCloudFoundryClient(token,orgName,spaceName);
        client.deleteDomain(domainName);

        LOGGER.info("End deleteDomain service. domainName : "+domainName);
        return true;
    }

}
