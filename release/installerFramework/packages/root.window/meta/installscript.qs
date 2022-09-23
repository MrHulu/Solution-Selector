function Component() {
    let page = gui.pageWidgetByObjectName("FinishedPage")
    if (page) {
        page.entered.connect(updateFinishedPageMessageLabel)
    }
}


updateFinishedPageMessageLabel = function() {
    let page = gui.pageWidgetByObjectName("FinishedPage")
    let label = page ? gui.findChild(page, "MessageLabel") : null
    if (label && installer.isUpdater()) {
        label.text = "请点击重启按钮去更新程序直到提示\"无可用更新\""
    }

//    if (installer.isInstaller()) {
//        const settingsContents = (function() {
//            const key = "HuluMan"
//            const command = installer.containsValue(key) ? installer.value(key) : "release"
//            switch (command) {
//            default: return "[General]\nHuluMan=" + command
//            case "release": return "[General]\nHuluMan=release"
//            }
//        })()

//        const commands ='${PersonalDir} = (Get-ItemPropertyValue -Path \"Registry::HKEY_CURRENT_USER\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Explorer\\User Shell Folders\" -Name \"Personal\");${SolutionSelectorConfigDir} = \"${PersonalDir}\\方案选择助手\";if ((Test-Path -Path ${SolutionSelectorConfigDir}) -eq ${False}) { New-Item -Path \"${SolutionSelectorConfigDir}\" -ItemType \"Directory\" -Force | Out-Null; } ${SettingsContent}=\"' + settingsContents + '\"; Out-File -Encoding \"utf8\" -FilePath \"${SolutionSelectorConfigDir}\\settings.ini\" -InputObject ${SettingsContent};'
//        installer.execute("PowerShell.exe", ["-Command", "& {" + commands + "}"]);
//    }
}

Component.prototype.createOperations = function() {
    component.createOperations();

    if (systemInfo.productType === "windows") {
        component.addOperation(
            "CreateShortcut",
            "@TargetDir@/MaintenanceTool.exe", 
            "@StartMenuDir@/MaintenanceTool.lnk",
            "workingDirectory=@TargetDir@", 
            "description=" + qsTranslate("installscript", "Start 方案选择助手 Maintenance Tool"));
        component.addOperation(
            "CreateShortcut",
            "@TargetDir@/方案选择助手.exe",
            "@StartMenuDir@/方案选择助手.lnk",
            "workingDirectory=@TargetDir@",
            "description=" + qsTranslate("installscript", "Launch 方案选择助手"));
        component.addOperation(
            "CreateShortcut",
            "@TargetDir@/方案选择助手.exe",
            "@DesktopDir@/方案选择助手.lnk",
            "workingDirectory=@TargetDir@",
            "description=" + qsTranslate("installscript", "Launch 方案选择助手"));
    }
}
