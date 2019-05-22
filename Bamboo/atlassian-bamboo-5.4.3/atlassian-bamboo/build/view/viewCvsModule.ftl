[#-- @ftlvariable name="action" type="com.atlassian.bamboo.ww2.actions.chains.admin.ViewPlanConfiguration" --]
[#-- @ftlvariable name="" type="com.atlassian.bamboo.ww2.actions.chains.admin.ViewPlanConfiguration" --]
[#assign repositories=action.getRepositoryDefinitions('com.atlassian.bamboo.plugin.system.repository:cvs', selectedRepositories)/]
[#if repositories?has_content]
    [#list repositories as repositoryDefinition]
        [@ww.hidden name="selectedRepositories" value=repositoryDefinition.id /]
        [#assign repository=repositoryDefinition.repository/]
        [@ww.label labelKey='repository.name' value=repositoryDefinition.name /]
        [@ww.label labelKey='repository.cvs.module' value=repository.module /]
        [@ww.label labelKey='repository.cvs.module.branch' value=repository.branchName hideOnNull='true' /]
   [/#list]
[#else]
   [@ww.text name='bulkAction.repo.notPlugin' /]
[/#if]