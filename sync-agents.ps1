# Sincroniza los agentes vivos de ~/.config/opencode hacia docs/agentes/
# Sanitiza rutas locales y elimina frontmatter YAML para render limpio en MkDocs.
$ErrorActionPreference = "Stop"

$src = Join-Path $env:USERPROFILE ".config\opencode"
$dst = Join-Path $PSScriptRoot "docs\agentes"
New-Item -ItemType Directory -Force -Path $dst | Out-Null

function Sanitize([string]$text) {
    $projects = Join-Path $env:USERPROFILE "Projects"
    $config   = Join-Path $env:USERPROFILE ".config\opencode"
    $text = $text.Replace($projects, "~/Projects")
    $text = $text.Replace($config, "~/.config/opencode")
    # Elimina bloque de frontmatter YAML inicial (--- ... ---)
    $text = $text -replace '(?s)\A---\r?\n.*?\r?\n---\r?\n\s*', ''
    return $text.TrimStart()
}

$copies = @(
    @{ File = "$src\agent\El-Boss.md";                        Out = "El-Boss.md";                 Title = "El-Boss (agente principal)" },
    @{ File = "$src\agent\reportero-estadistico.md";          Out = "reportero-estadistico.md";   Title = "reportero-estadistico (subagente)" },
    @{ File = "$src\skill\reportes-estadisticos\SKILL.md";    Out = "SKILL-reportes.md";          Title = "Skill: reportes-estadisticos" }
)

foreach ($c in $copies) {
    if (-not (Test-Path -LiteralPath $c.File)) {
        Write-Warning "No existe: $($c.File). Se omite."
        continue
    }
    $raw = Get-Content -LiteralPath $c.File -Raw -Encoding UTF8
    $body = Sanitize $raw
    $content = "# $($c.Title)`r`n`r`n> Copia sincronizada automaticamente desde ``~/.config/opencode``. No editar aqui: usar ``sync-agents.ps1``.`r`n`r`n$body`r`n"
    Set-Content -LiteralPath (Join-Path $dst $c.Out) -Value $content -Encoding UTF8
    Write-Host "OK -> docs/agentes/$($c.Out)"
}

Write-Host "`nSincronizacion completada. Recuerda: git add . ; git commit ; git push"
