# Script PowerShell pour lancer les variantes du Benchmark

$ProjectDir = "C:\Users\youbitech\Desktop\Benchmark"
Set-Location $ProjectDir

function Show-Menu {
    Clear-Host
    Write-Host "===================================="
    Write-Host "Benchmark REST Services Launcher"
    Write-Host "===================================="
    Write-Host ""
    Write-Host "Variantes disponibles:"
    Write-Host "1. Variante A (Jersey + JPA)"
    Write-Host "2. Variante C (Spring MVC + JPA)"
    Write-Host "3. Variante D (Spring Data REST)"
    Write-Host "4. Demarrer infrastructure Docker"
    Write-Host "5. Arreter infrastructure Docker"
    Write-Host "6. Status infrastructure Docker"
    Write-Host "7. Test endpoint (GET /categories)"
    Write-Host "8. Ouvrir Grafana (http://localhost:3000)"
    Write-Host "9. Ouvrir Prometheus (http://localhost:9090)"
    Write-Host "0. Quitter"
    Write-Host ""
}

function Start-Variant {
    param(
        [string]$Profile,
        [string]$Name
    )

    Clear-Host
    Write-Host "Compilation de la Variante $Name..."
    Write-Host ""

    & mvn clean compile

    if ($LASTEXITCODE -eq 0) {
        Write-Host ""
        Write-Host "Lancement de la Variante $Name sur le port 8080..."
        Write-Host "Acces: http://localhost:8080"
        Write-Host ""
        Write-Host "Appuyez sur Ctrl+C pour arreter."
        Write-Host ""

        & mvn spring-boot:run -Dspring-boot.run.profiles=$Profile `
            -Dspring-boot.run.arguments="--server.port=8080"
    }
    else {
        Write-Host "Erreur de compilation!" -ForegroundColor Red
        Read-Host "Appuyez sur Entree pour continuer"
    }
}

function Start-Docker {
    Write-Host "Demarrage de l'infrastructure Docker Compose..."
    Write-Host ""
    & docker-compose up -d
    Write-Host ""
    Write-Host "Infrastructure demarree!" -ForegroundColor Green
    Write-Host "- PostgreSQL: localhost:5432 (postgres/postgres)"
    Write-Host "- Prometheus: http://localhost:9090"
    Write-Host "- Grafana: http://localhost:3000 (admin/admin)"
    Write-Host "- InfluxDB: http://localhost:8086 (admin/admin123)"
    Write-Host ""
    Read-Host "Appuyez sur Entree pour continuer"
}

function Stop-Docker {
    Write-Host "Arret de l'infrastructure Docker Compose..."
    Write-Host ""
    & docker-compose down
    Write-Host ""
    Write-Host "Infrastructure arretee!" -ForegroundColor Yellow
    Write-Host ""
    Read-Host "Appuyez sur Entree pour continuer"
}

function Show-DockerStatus {
    Write-Host "Status de l'infrastructure Docker:"
    Write-Host ""
    & docker-compose ps
    Write-Host ""
    Read-Host "Appuyez sur Entree pour continuer"
}

function Test-Endpoint {
    Write-Host "Test d'accès à l'API..."
    Write-Host ""
    try {
        $Response = Invoke-WebRequest -Uri "http://localhost:8080/categories?page=0&size=5" `
            -Method GET `
            -ContentType "application/json" `
            -TimeoutSec 5

        Write-Host "Status: $($Response.StatusCode)" -ForegroundColor Green
        Write-Host "Reponse (JSON):"
        $Response.Content | ConvertFrom-Json | ConvertTo-Json -Depth 2 | Write-Host
    }
    catch {
        Write-Host "Erreur: $_" -ForegroundColor Red
        Write-Host ""
        Write-Host "Assurez-vous que l'application est demarree sur le port 8080"
    }
    Write-Host ""
    Read-Host "Appuyez sur Entree pour continuer"
}

function Open-Browser {
    param([string]$Url)
    Start-Process $Url
}

# Boucle principale
do {
    Show-Menu
    $choice = Read-Host "Choisissez une option [0-9]"

    switch ($choice) {
        "1" {
            Start-Variant "jersey" "A"
        }
        "2" {
            Start-Variant "mvc" "C"
        }
        "3" {
            Start-Variant "data-rest" "D"
        }
        "4" {
            Start-Docker
        }
        "5" {
            Stop-Docker
        }
        "6" {
            Show-DockerStatus
        }
        "7" {
            Test-Endpoint
        }
        "8" {
            Open-Browser "http://localhost:3000"
            Write-Host "Ouverture de Grafana dans le navigateur..." -ForegroundColor Green
        }
        "9" {
            Open-Browser "http://localhost:9090"
            Write-Host "Ouverture de Prometheus dans le navigateur..." -ForegroundColor Green
        }
        "0" {
            Write-Host "Fermeture du launcher." -ForegroundColor Yellow
            exit
        }
        default {
            Write-Host "Choix invalide. Veuillez reessayer." -ForegroundColor Red
            Read-Host "Appuyez sur Entree"
        }
    }
} while ($true)

