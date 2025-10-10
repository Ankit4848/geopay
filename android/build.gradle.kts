allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

rootProject.layout.buildDirectory = layout.buildDirectory.dir("../build").get()

subprojects {
    project.layout.buildDirectory = rootProject.layout.buildDirectory.dir(project.name).get()
}

// Ensure APK outputs are copied to the expected Flutter location
tasks.register("copyApkToFlutterLocation") {
    doLast {
        val sourceDir = file("build/app/outputs/flutter-apk")
        val targetDir = file("../build/app/outputs/flutter-apk")
        if (sourceDir.exists()) {
            targetDir.mkdirs()
            sourceDir.listFiles()?.forEach { file ->
                if (file.extension == "apk") {
                    file.copyTo(File(targetDir, file.name), overwrite = true)
                }
            }
        }
    }
}

// Ensure Bundle outputs are copied to the expected Flutter location
tasks.register("copyBundleToFlutterLocation") {
    doLast {
        val sourceDir = file("build/app/outputs/bundle")
        val targetDir = file("../build/app/outputs/bundle")
        if (sourceDir.exists()) {
            targetDir.mkdirs()
            sourceDir.listFiles()?.forEach { folder ->
                if (folder.isDirectory) {
                    folder.listFiles()?.forEach { file ->
                        if (file.extension == "aab") {
                            val targetFolder = File(targetDir, folder.name)
                            targetFolder.mkdirs()
                            file.copyTo(File(targetFolder, file.name), overwrite = true)
                        }
                    }
                }
            }
        }
    }
}

subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
