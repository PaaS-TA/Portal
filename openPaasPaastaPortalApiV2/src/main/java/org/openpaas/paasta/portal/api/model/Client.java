package org.openpaas.paasta.portal.api.model;

/**
 * Created by YJKim on 2016-10-10.
 */
public class Client {

    private int pageOffset;
    private String clientId;
//    private String name;
//    private String client_secret;
//    private String clientId;
//    private String clientId;
//    private String clientId;private String clientId;
//    private String clientId;




    public int getPageOffset() {
        return pageOffset;
    }

    public void setPageOffset(int pageOffset) {
        this.pageOffset = pageOffset;
    }

    public String getClientId() {
        return clientId;
    }

    public void setClientId(String clientId) {
        this.clientId = clientId;
    }
}
