[#-- @ftlvariable name="action" type="com.atlassian.bamboo.ww2.BambooActionSupport" --]

[#function hasPlanPermission permission plan]
    [#return action.hasPlanPermission(permission, plan)]
[/#function]

[#function hasEntityPermission permission object]
    [#return action.hasEntityPermission(permission, object)]
[/#function]


[#function hasPlanPermissionForKey permission planKey]
    [#return action.hasPlanPermission(permission, planKey)]
[/#function]

[#function hasGlobalPermission permission]
     [#if ctx?has_content]
        [#return ctx.hasGlobalPermission(permission)]
     [#else]
        [#return action.hasGlobalPermission(permission)]
     [/#if]
[/#function]

[#function hasGlobalAdminPermission]
    [#if ctx?has_content]
        [#return ctx.hasGlobalAdminPermission()]
     [#else]
        [#return action.hasGlobalAdminPermission()]
    [/#if]
[/#function]

[#function hasRestrictedAdminPermission]
    [#if ctx?has_content]
        [#return ctx.hasRestrictedAdminPermission()]
    [#else]
        [#return action.hasRestrictedAdminPermission()]
    [/#if]
[/#function]

[#function hasAdminPermission]
    [#if ctx?has_content]
        [#return ctx.hasAdminPermission()]
    [#else]
        [#return action.hasAdminPermission()]
    [/#if]
[/#function]

[#function getUserFullName user='']
    [#if user?has_content]
        [#if user.fullName?has_content]
            [#return user.fullName]
        [#else]
            [#if user.name?has_content]
                [#return user.name]
            [#else]
                [#return "Name Unknown"]
            [/#if]
        [/#if]
    [#else]
        [#return "Anonymous User"]
    [/#if]
[/#function]

[#function getAuthorFullName author='']
    [#if author?has_content]
        [#if author.fullName?has_content]
            [#return author.fullName]
        [#else]
            [#if author.name?has_content]
                [#return author.name]
            [#else]
                [#return "[unknown]"]
            [/#if]
        [/#if]
    [#else]
        [#return "[unknown]"]
    [/#if]
[/#function]

[#function sanitizeUri uri]
    [#return uri?replace("[\"'<>\\\\]", "", "r")]
[/#function]


[#--
 According to the HTML standard, ID and NAME tokens must begin with a letter ([A-Za-z])
 and may be followed by any number of letters,
 digits ([0-9]), hyphens ("-"), underscores ("_"), colons (":"), and periods (".").

 This method replaces all invalid characters in the supplied id with an underscore. It does not enforce the
 "must begin with a letter" rule.

 There are two functions that do it, one in FreeMarker functions.ftl and one in BambooStringUtils. They MUST be
 kept in sync.
--]
[#function forceValidHtmlId htmlId]
    [#return htmlId?replace("[^-A-Za-z0-9_:.]", "_", "r")]
[/#function]

[#-- ================================================================================================= @ui.getTestCaseResultUrl --]
[#function getTestCaseResultUrl buildKey buildNumber testCaseId]
    [#return "/browse/${buildKey}-${buildNumber}/test/case/${testCaseId}"]
[/#function]
[#-- ================================================================================================= @ui.getViewTestCaseHistoryUrl --]
[#function getViewTestCaseHistoryUrl buildKey testCaseId]
    [#return "/browse/${buildKey}/test/case/${testCaseId}" ]
[/#function]

[#function getPlanEditLink build]
    [#if !isChain(build)]
        [#return "${req.contextPath}/build/admin/edit/editBuildConfiguration.action?buildKey=${build.key}"]
    [#else]
        [#return "${req.contextPath}/chain/admin/config/editChainConfiguration.action?buildKey=${build.key}"]
    [/#if]
[/#function]

[#function getPlanRunLink build]
    [#return "${req.contextPath}/build/admin/triggerManualBuild.action?buildKey=${build.key}"]
[/#function]

[#function getPlanStopLink build]
    [#return "${req.contextPath}/build/admin/ajax/stopPlan.action?planKey=${build.key}"]
[/#function]

[#function getPlanStatusIcon buildResult]
    [#if buildResult.buildState == 'Successful' && (buildResult.continuable)!false]
        [#return 'SuccessfulPartial' /]
    [/#if]
    [#if (buildResult.notRunYet)!false]
        [#return 'NotRunYet' /]
    [/#if]
    [#if buildResult.finished]
        [#return buildResult.buildState /]
    [#else]
        [#return buildResult.lifeCycleState /]
    [/#if]
[/#function]

[#function isChain plan]
    [#return plan?? && (plan.planType == 'CHAIN' || plan.planType == 'CHAIN_BRANCH')]
[/#function]

[#function getPlanI18nKeyPrefix plan]
    [#if plan.planType == 'CHAIN']
        [#return 'chain'/]
    [#elseif plan.planType == 'JOB']
        [#return 'job'/]
    [#elseif plan.planType == 'CHAIN_BRANCH']
        [#return 'branch'/]
    [/#if]
    [#return 'unexpected'/]
[/#function]

[#function isBranch plan]
    [#return plan?? && plan.planType == 'CHAIN_BRANCH']
[/#function]

[#function isJob plan]
    [#return plan?? && plan.planType == 'JOB']
[/#function]

[#function ognlLiteral value]
    [#return '%{"${value?j_string}"}'/]
[/#function]

[#function renderExtraAttributes extraAttributes]
    [#local output = '' /]
    [#list extraAttributes?keys as attr]
        [#local output = output + ' ${attr}="${extraAttributes[attr]}"' /]
    [/#list]
    [#return output /]
[/#function]

[#function resolveName text="" textKey=""]
    [#local output = '' /]
        [#if text?has_content]
            [#local output = text /]
        [#elseif textKey?has_content]
            [#local output][@ww.text name=textKey /][/#local]
        [/#if]
    [#return output]
[/#function]

[#-- JavaScript related functions --]
[#function jqueryObjectOrUndefined id='']
    [#if id?has_content]
        [#return "$('#"+id+"')"]
    [#else]
        [#return "undefined"]
    [/#if]
[/#function]

[#function stringOrUndefined value='']
    [#if value?has_content]
        [#return "'${value}'"]
    [#else]
        [#return "undefined"]
    [/#if]
[/#function]