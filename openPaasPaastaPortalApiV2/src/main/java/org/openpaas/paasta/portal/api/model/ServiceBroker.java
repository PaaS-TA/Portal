package org.openpaas.paasta.portal.api.model;

public class ServiceBroker extends Entity {
	private String url;
	private String username;
    private String password;
    private String newName;

	public ServiceBroker(String url, String username) {
		this.url = url;
		this.username = username;
	}

    public ServiceBroker(String url, String username, String password) {
        this.url = url;
        this.username = username;
        this.password = password;
    }

    public ServiceBroker(Meta meta, String name, String url, String username) {
		super(meta, name);
		this.url = url;
		this.username = username;
	}

    public ServiceBroker(Meta meta, String name, String url, String username, String password) {
        super(meta, name);
        this.url = url;
        this.username = username;
        this.password = password;
    }

    public String getUrl() {
		return url;
	}

	public String getUsername() {
		return username;
	}

    public String getPassword() {
        return password;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getNewName() {
        return newName;
    }

    public void setNewName(String newName) {
        this.newName = newName;
    }
}
