[#assign fieldsetId = ""/]
[#if (parameters.id)?has_content]
    [#assign fieldsetId = "fieldArea_${parameters.id}"/]
[/#if]
[#assign fieldsetClass = "group"/]
[#if parameters.required!false]
    [#assign fieldsetClass = fieldsetClass + " required"/]
[/#if]
[#assign fieldsetDependsOn = (parameters.dependsOn)!""/]
[#assign fieldsetShowOn = (parameters.showOn)!true/]

[@ui.bambooSection id=fieldsetId cssClass=fieldsetClass dependsOn=fieldsetDependsOn showOn=fieldsetShowOn]
    [#if parameters.label?? || parameters.labelKey??]
        <legend[#if (parameters.id)?has_content] id="fieldLabelArea_${parameters.id}"[/#if]><span>[#rt/]
            [#if parameters.labelKey?has_content]
                [@ww.text name=parameters.labelKey /][#t/]
            [#elseif parameters.label?has_content]
                ${parameters.label}[#t/]
            [/#if]
            [#if parameters.required!false]
                <span class="aui-icon icon-required"></span><span class="content"> (required)</span>[#t/]
            [/#if]
        </span></legend>[#lt/]
    [/#if]

    [#assign itemCount = 0/]
    [#if parameters.list??]
        [#if parameters.matrix!false]
            <div class="matrix[#if parameters.matrixCssClass??] ${parameters.matrixCssClass?html}[/#if]">
        [/#if]

        [@ww.iterator value="parameters.list"]
            [#assign itemCount = itemCount + 1/]
            [#assign checkBoxEnabled = true /]

            [#if parameters.listKey??]
                [#assign itemKey = stack.findValue(parameters.listKey)/]
            [#else]
                [#assign itemKey = stack.findValue('top')/]
            [/#if]
            [#if parameters.listValue??]
                [#assign itemValue = stack.findString(parameters.listValue)/]
            [#else]
                [#assign itemValue = stack.findString('top')/]
            [/#if]
            [#if parameters.listChecked??]
                [#assign itemChecked = stack.findValue(parameters.listChecked)!false/]
            [#else]
                [#assign itemChecked = tag.contains(parameters.nameValue, itemKey)/]
            [/#if]
            <div class="checkbox">
                <input type="checkbox" class="checkbox" name="${parameters.name?html}" value="${itemKey?html}" id="${parameters.name?html}-${itemCount}" [#rt/]
                    [#if itemChecked]checked="checked" [#t/][/#if]
                    [#if parameters.disabled!false || (parameters.disabledList?? && tag.contains(stack.findValue(parameters.disabledList), itemKey))]
                        [#assign checkBoxEnabled = false /]
                        disabled="disabled" [#t/]
                    [/#if]
                    [#if parameters.title??]title="${parameters.title?html}" [#t/][/#if]
                    [#include "/${parameters.templateDir}/simple/scripting-events.ftl" /]
                />[#lt/]
                <label for="${parameters.name?html}-${itemCount}">[#rt]
                    [#if parameters.i18nPrefixForValue?has_content]
                        [@ww.text name='${parameters.i18nPrefixForValue}.${itemValue}' /][#lt]
                    [#else]
                        ${itemValue?html}[#lt/]
                    [/#if]
                    [#if parameters.disabledMessageKey?has_content && !checkBoxEnabled]
                        [@ww.text name='${parameters.disabledMessageKey}' /][#t/]
                    [/#if]
                </label>[#lt]
            </div>
        [/@ww.iterator]
        [#if parameters.matrix?? && parameters.matrix==true]
            </div>
        [/#if]
    [/#if]

    <input type="hidden" name="checkBoxFields" value="${parameters.name?html}" />

    [#assign fieldFooterInfo][#include "/${parameters.templateDir}/${parameters.theme}/controlfooter-core.ftl" /][/#assign]
    [#if fieldFooterInfo?trim?has_content]
        <div class="field-group">${fieldFooterInfo}</div>
    [/#if]
[/@ui.bambooSection]