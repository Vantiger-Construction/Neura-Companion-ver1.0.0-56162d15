plugins {
    kotlin("jvm") version "1.9.0"
    id("org.jetbrains.compose") version "1.4.0"
}

repositories {
    google()
    mavenCentral()
    maven("https://maven.pkg.jetbrains.space/public/p/compose/dev")
}

dependencies {
    implementation(compose.desktop.currentOs)
    
    // Dependency Injection
    implementation("io.insert-koin:koin-core:3.4.0")
    
    // HTTP & AI
    implementation("com.theokanning.openai-gpt3-java:client:0.10.3")
    implementation("io.ktor:ktor-client-cio:2.4.0")

    // Azure Storage
    implementation("com.azure:azure-storage-blob:12.21.0")

    // PDF & CSV
    implementation("org.apache.pdfbox:pdfbox:2.0.29")
    implementation("com.opencsv:opencsv:5.8.0")

    // Database (SQLite)
    implementation("org.xerial:sqlite-jdbc:3.41.2.1")

    // Coroutines
    implementation("org.jetbrains.kotlinx:kotlinx-coroutines-core:1.7.1")

    // JSON
    implementation("com.squareup.moshi:moshi:1.15.0")
}

compose.desktop {
    application {
        mainClass = "MainKt"
        nativeDistributions {
            targetFormats(org.jetbrains.compose.desktop.application.dsl.TargetFormat.Msi)
            packageName = "Neuro Companion"
            packageVersion = "1.0.0"
        }
    }
}