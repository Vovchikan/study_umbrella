# Study.Umbrella

Проект для экспериментов и изучения 🧐.

## Clean start
```shell
mix setup
PORT=4014 iex -S mix phx.server
```

> Default port is 4000. It's getting from runtime.exs

Phoenix - http://localhost:4014

## Flash auto-dismiss

По умолчанию все типы flash-сообщений (`:info`, `:error`) имеют `nil` таймаут — не закрываются автоматически. Для включения нужно явно задать конфигурацию.

### Конфигурация

```elixir
# config/config.exs
config :study_web, :flash,
  auto_dismiss: %{
    info: 5_000,
    error: 10_000
  }
```

### Переопределение через env

`config/runtime.exs` переопределяет конфиг:

```shell
FLASH_INFO_TIMEOUT=500 FLASH_ERROR_TIMEOUT=500 iex -S mix phx.server
```

### Переопределение в HEEx (атрибут `timeouts`)

Атрибут мержится поверх конфига (приоритет: `timeouts` > `config` > `nil`):

```heex
<Layouts.flash_group flash={@flash} timeouts={%{info: 10_000, error: 2_000}} />
<Layouts.app flash={@flash} timeouts={%{info: 10_000}} />
<Layouts.flash_group flash={@flash} timeouts={%{}} /> <%!-- отключить для этой страницы --%>
```

Использует `Application.get_env(:study_web, :flash)` в рантайме, поэтому изменения конфига и env применяются без перекомпиляции.

### Как добавить новый тип (например `:warning`)

1. `apps/study_web/lib/study_web/components/core_components.ex:45` — расширить `values`:

   ```elixir
   attr :kind, :atom, values: [:info, :error, :warning]
   ```

   Добавить класс и иконку в `flash/1`:

   ```elixir
   @kind == :warning && "alert-warning"
   <.icon :if={@kind == :warning} name="hero-exclamation-triangle" ... />
   ```

2. `apps/study_web/lib/study_web/components/layouts.ex:91` — добавить в `flash_group`:

   ```heex
   <.flash kind={:warning} flash={@flash} timeout={@timeouts[:warning]} />
   ```

3. `config/runtime.exs:16` — добавить env:

   ```elixir
   warning: System.get_env("FLASH_WARNING_TIMEOUT")
   ```

После этого можно настроить `auto_dismiss` для нового типа в конфиг файле:

   ```elixir
   config :study_web, :flash, auto_dismiss: %{warning: 3_000}
   ```

## Learn more

* Official website: https://www.phoenixframework.org/
* Guides: https://hexdocs.pm/phoenix/overview.html
* Docs: https://hexdocs.pm/phoenix
* Forum: https://elixirforum.com/c/phoenix-forum
* Source: https://github.com/phoenixframework/phoenix