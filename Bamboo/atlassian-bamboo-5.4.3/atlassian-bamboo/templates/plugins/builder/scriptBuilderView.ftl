[@ww.label labelKey='builder.script.script' name='build.buildDefinition.builder.script' /]
[@ww.label labelKey='builder.command.argument' name='build.buildDefinition.builder.argument' hideOnNull='true' /]        
[@ww.label labelKey='builder.common.env' name='build.buildDefinition.builder.environmentVariables' hideOnNull='true' /]
[@ww.label labelKey='builder.common.sub' name='build.buildDefinition.builder.workingSubDirectory' hideOnNull='true' /]
[#if build.buildDefinition.builder.hasTests()]
    [@ww.label labelKey='builder.common.tests.directory' name='build.buildDefinition.builder.testResultsDirectory' hideOnNull='true' /]
[/#if]
