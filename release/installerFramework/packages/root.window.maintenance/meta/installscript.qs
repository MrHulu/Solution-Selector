// constructor
function Component()
{
    installer.installationStarted.connect(this, Component.prototype.onInstallationStarted);
}

Component.prototype.onInstallationStarted = function()
{
    if (component.updateRequested() || component.installationRequested()) {
        component.installerbaseBinaryPath = "@TargetDir@/installerbase.exe";
        installer.setInstallerBaseBinary(component.installerbaseBinaryPath);
    }
}

Component.prototype.createOperationsForArchive = function(archive)
{
    installer.performOperation("SimpleMoveFile",
        new Array("@TargetDir@", "@TargetDir@_backup"));
    component.createOperationsForArchive(archive);
}