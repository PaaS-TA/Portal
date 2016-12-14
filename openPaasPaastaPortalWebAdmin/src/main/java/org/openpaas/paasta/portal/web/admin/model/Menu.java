package org.openpaas.paasta.portal.web.admin.model;

/**
 * org.openpaas.paasta.portal.web.admin.model
 *
 * @author rex
 * @version 1.0
 * @since 2016.09.29
 */
public class Menu {

    private int no;
    private int id;
    private int parentNo;
    private int sortNo;
    private String menuName;
    private String text;
    private String menuPath;
    private String imagePath;
    private String openWindowYn;
    private String loginYn;
    private String useYn;
    private String description;
    private String userId;
    private String created;
    private String lastModified;

    private int childCount;
    private int maxNo;

    public int getNo() {
        return no;
    }

    public void setNo(int no) {
        this.no = no;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getParentNo() {
        return parentNo;
    }

    public void setParentNo(int parentNo) {
        this.parentNo = parentNo;
    }

    public int getSortNo() {
        return sortNo;
    }

    public void setSortNo(int sortNo) {
        this.sortNo = sortNo;
    }

    public String getMenuName() {
        return menuName;
    }

    public void setMenuName(String menuName) {
        this.menuName = menuName;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    public String getMenuPath() {
        return menuPath;
    }

    public void setMenuPath(String menuPath) {
        this.menuPath = menuPath;
    }

    public String getImagePath() {
        return imagePath;
    }

    public void setImagePath(String imagePath) {
        this.imagePath = imagePath;
    }

    public String getOpenWindowYn() {
        return openWindowYn;
    }

    public void setOpenWindowYn(String openWindowYn) {
        this.openWindowYn = openWindowYn;
    }

    public String getLoginYn() {
        return loginYn;
    }

    public void setLoginYn(String loginYn) {
        this.loginYn = loginYn;
    }

    public String getUseYn() {
        return useYn;
    }

    public void setUseYn(String useYn) {
        this.useYn = useYn;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getCreated() {
        return created;
    }

    public void setCreated(String created) {
        this.created = created;
    }

    public String getLastModified() {
        return lastModified;
    }

    public void setLastModified(String lastModified) {
        this.lastModified = lastModified;
    }

    public int getChildCount() {
        return childCount;
    }

    public void setChildCount(int childCount) {
        this.childCount = childCount;
    }

    public int getMaxNo() {
        return maxNo;
    }

    public void setMaxNo(int maxNo) {
        this.maxNo = maxNo;
    }

    @Override
    public String toString() {
        return "Menu{" +
                "no=" + no +
                ", id=" + id +
                ", parentNo=" + parentNo +
                ", sortNo=" + sortNo +
                ", menuName='" + menuName + '\'' +
                ", text='" + text + '\'' +
                ", menuPath='" + menuPath + '\'' +
                ", imagePath='" + imagePath + '\'' +
                ", openWindowYn='" + openWindowYn + '\'' +
                ", loginYn='" + loginYn + '\'' +
                ", useYn='" + useYn + '\'' +
                ", description='" + description + '\'' +
                ", userId='" + userId + '\'' +
                ", created='" + created + '\'' +
                ", lastModified='" + lastModified + '\'' +
                ", childCount=" + childCount +
                ", maxNo=" + maxNo +
                '}';
    }
}
