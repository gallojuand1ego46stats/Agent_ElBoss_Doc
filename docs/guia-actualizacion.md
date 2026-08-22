# Guia de actualizacion

Esta documentacion es **viva**: los agentes cambian y el sitio debe seguirlos. El flujo esta disenado para que actualizar tome menos de un minuto.

## Caso 1: modifique un agente o la skill

Los agentes viven en `~/.config/opencode/`. Este sitio publica **copias**. Para refrescarlas:

```powershell
cd ~/Projects/Agent_ElBoss_Doc
powershell -ExecutionPolicy Bypass -File sync-agents.ps1
```

El script hace automaticamente:

- Copia `El-Boss.md`, `reportero-estadistico.md` y `SKILL.md` hacia `docs/agentes/`.
- Sanitiza rutas locales (`C:\Users\...` -> rutas relativas) antes de publicarlas.
- Elimina el frontmatter YAML para que MkDocs lo renderice limpio.

Luego publica:

```powershell
git add .
git commit -m "docs: sincronizar cambios de agentes"
git push
```

## Caso 2: modifique las paginas del sitio

Edita directamente `docs/*.md` (index, arquitectura, guia) y haz `git add . ; git commit ; git push`.

## Caso 3: quiero previsualizar antes de publicar

```powershell
pip install -r requirements.txt
mkdocs serve
```

Abre <http://localhost:8000> en tu navegador. Con `Ctrl+C` detienes el servidor.

## Que pasa despues de cada push

GitHub Actions ejecuta el workflow **Deploy Docs**:

1. Instala MkDocs Material.
2. Compila el sitio.
3. Lo despliega a GitHub Pages.

En 1-2 minutos el sitio refleja los cambios. Verifica el estado:

```powershell
gh run list --repo gallojuand1ego46stats/Agent_ElBoss_Doc --limit 3
```

## Solucion de problemas

| Sintoma | Causa probable | Solucion |
|---|---|---|
| El badge rojo en README | Fallo el build | Revisar la pestana Actions del repo |
| El sitio no actualiza | Caché del navegador | Recargar con Ctrl+F5 |
| `sync-agents.ps1` advierte "No existe" | Ruta de la skill cambio | Actualizar la variable `$copies` del script |
| Mermaid no renderiza | Extension faltante | Verificar `pymdownx.superfences` en `mkdocs.yml` |
