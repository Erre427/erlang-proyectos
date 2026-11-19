# Manual: Estación Meteorológica (Proyecto 05) en Erlang/OTP

| Dato | Valor |
|---|---|
| **Alumno** | Marcos Daniel García Rodríguez |
| **No. de control** | 23211969 |
| **Materia** | Programación Lógica y Funcional |
| **Maestro** | René Solís |
| **Repositorio** | https://github.com/Erre427/erlang-proyectos/tree/main/proyectos/05-estacion-meteorologica |

---

## 1. Descripción
Sistema concurrente en Erlang/OTP que simula una estación meteorológica. Sensores virtuales generan lecturas de temperatura, humedad, presión y viento. Un agregador calcula promedios de 1 minuto y de 1 hora. Un servidor HTTP (Cowboy) expone los datos y un dashboard web los muestra en tiempo real.

## 2. Arquitectura

| Módulo | Función |
|---|---|
| `app` | Arranque de la aplicación OTP |
| `sup` | Supervisor con estrategia `rest_for_one` |
| `store` | Almacén de lecturas en tablas ETS |
| `agregador` | Cálculo de promedios por ventana de tiempo |
| `sensor` | Generación periódica de lecturas simuladas |
| `server` / `handlers` | Servidor Cowboy y manejadores HTTP |

**Supervisión (`rest_for_one`):** los procesos se arrancan en orden de dependencia. Si cae `store`, el supervisor reinicia también los procesos que dependen de él, que son los que arrancaron después. Así se evita que sensores o agregador escriban en una ETS que ya no existe.

## 3. Entorno
- AWS Academy, Ubuntu 24.04 (`t3.medium` o `t4g.medium`)
- Erlang/OTP 27.2 y Rebar 3.24.0 (instalados con `asdf`)
- Cowboy 2.12.0
- Puerto **8080** abierto en el Security Group

## 4. Instalación en la VM

```bash
sudo apt update && sudo apt install -y git tmux build-essential autoconf m4 libncurses-dev libssl-dev curl
git clone https://github.com/<tu-usuario>/erlang-proyectos.git
cd erlang-proyectos
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.14.0
echo '. ~/.asdf/asdf.sh' >> ~/.bashrc && source ~/.bashrc
asdf plugin add erlang && asdf plugin add rebar
asdf install erlang 27.2 && asdf global erlang 27.2
asdf install rebar 3.24.0 && asdf global rebar 3.24.0
```

## 5. Ejecución

```bash
tmux new -s demo
cd ~/erlang-proyectos/proyectos/05-estacion-meteorologica
rebar3 compile
rebar3 eunit
rebar3 shell
```

Abre en el navegador: `http://<IP_PUBLICA>:8080`

## 6. API HTTP

| Método y ruta | Descripción |
|---|---|
| `GET /` | Dashboard web (`priv/index.html`) |
| `GET /api/promedios` | Promedios de 1 min y 1 h en JSON |
| `GET /metrics` | Métricas (incluye `estacion_lecturas_total`) |
| `POST /api/lecturas` | Envía una lectura manual |

Ejemplo:
```bash
curl http://localhost:8080/api/promedios
curl -X POST localhost:8080/api/lecturas -d '{"temperatura":22,"humedad":60,"presion":1013,"viento":10}'
```

## 7. Dashboard
Diseñado en Google Stitch y adaptado a HTML con Tailwind. Tiene 3 vistas:
- **Dashboard:** tarjetas con promedios, gráfica de tendencia y eventos recientes.
- **Detalle:** análisis por variable (promedios, mínimo y máximo de la sesión).
- **Bitácora:** eventos filtrables por OK, Alerta y Falla.

Consulta la API cada 3 s. Detecta caídas de la API, reinicios del supervisor (cuando el contador de lecturas vuelve a 0) y alertas por umbral (viento > 25 km/h, temperatura > 32 °C).

## 8. Pruebas

### 8.1 Pruebas unitarias
```bash
rebar3 eunit
```

### 8.2 Prueba de caos (tolerancia a fallos)
En el shell de Erlang (prompt `1>`):
```erlang
registered().
exit(whereis(p05_estacion_meteorologica_store), kill).
```
> Verifica el nombre exacto del proceso con `registered()`: <ajustar si es distinto>.

**Resultado esperado:** el supervisor reinicia `store` y los procesos dependientes. El dashboard sigue respondiendo y la Bitácora registra "Procesos reiniciados por el supervisor".

### 8.3 Prueba de alerta
```bash
for i in $(seq 1 30); do curl -s -X POST localhost:8080/api/lecturas -d '{"temperatura":22,"humedad":60,"presion":1013,"viento":60}'; done
```
Resultado esperado: aparece una ALERTA de viento en la Bitácora.

## 9. Flujo de despliegue
Editar en `github.dev` → Commit y Push → en la VM: `cd ~/erlang-proyectos && git pull` → recargar el navegador con `Ctrl+Shift+R`. Los cambios en `priv/index.html` no necesitan recompilar.

## 10. Evidencias
- Capturas del dashboard:
  
  <img width="666" height="759" alt="image" src="https://gist.github.com/user-attachments/assets/c5ad16f2-bc55-4494-9c54-de3e0ebb6a6e" />
- Capturas de la prueba de caos:
  
  <img width="1475" height="141" alt="image" src="https://gist.github.com/user-attachments/assets/f5b396e9-3998-419d-82f8-0df1e049dbcb" />

````
