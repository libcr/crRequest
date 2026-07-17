# crRequest

`crRequest` 是C++开发的 基于 Chromium 150.0.7871.91 内置的 Network Service 和 UI Views 构建的 API
请求工具。它可以编辑 cURL 请求、选择 HTTP 协议策略、发送 HTTP/HTTPS 请求，
并查看最终请求头、响应头、响应正文以及实际协商到的网络协议。

## Gallery

![crRequest 主界面：发送 Digest Auth 请求并查看响应](Screenshot%20From%202026-07-17%2018-51-34.png)

## 主要功能

- 支持 `GET`、`POST`、`PUT`、`PATCH`、`DELETE` 请求。
- 支持 Auto、HTTP/1.1、HTTP/2 和严格 HTTP/3（界面中显示为 QUIC）。
- 支持 Query 参数、请求头和请求正文编辑。
- 支持 Basic Auth 和 Digest Auth。
- cURL 编辑器与表单视图双向同步。
- 支持环境变量、请求历史、Collection 目录和多标签页。
- 显示实际发送的请求头，包括 Chromium 网络层自动添加的请求头。
- 显示 HTTP 状态行、响应头、响应正文、ALPN、实际连接协议和网络错误。
- 支持亮色/暗色主题以及可隐藏、可调整宽度的侧边栏。

## 启动

启动已构建或已安装的 `crRequest` 可执行文件。程序依赖随应用提供的
`crrequest_resources*.pak` 资源文件，请保留发行包原有的文件结构。

Linux 示例：

```bash
./crRequest
```

可以通过 `--lang` 指定区域：

```bash
./crRequest --lang=zh-CN
```

可用区域包括 `en-US`、`zh-CN`、`zh-HK`、`zh-TW`、`ar`、`fr`、
`fr-CA`、`ru`、`es`、`es-419`、`pt-BR` 和 `pt-PT`。当前 crRequest 自身的
业务界面文字仍以英文为主；区域设置主要影响 Chromium/Views 提供的系统界面资源。

## 发送第一个请求

1. 启动后会自动打开一个 `New Request` 标签页。
2. 在方法列表中选择请求方法。
3. 在 URL 输入框中输入完整的 `http://` 或 `https://` 地址。
4. 根据需要在 `Params`、`Authorization`、`Headers` 和 `Body` 中配置请求。
5. 选择协议策略；一般情况下保留 `Auto` 即可。
6. 点击 `Send`。
7. 程序会自动切换到 `Response`，显示协议诊断、响应头和响应正文。

例如，发送 JSON POST 请求：

```text
Method: POST
URL: https://httpbingo.org/post
Header: Content-Type = application/json
Body: {"name":"crRequest","enabled":true}
```

也可以直接把下面的内容粘贴到顶部 cURL 编辑器：

```bash
curl --request "POST" --url "https://httpbingo.org/post" \
  --header "Content-Type: application/json" \
  --data-raw "{\"name\":\"crRequest\",\"enabled\":true}"
```

## 请求编辑器

### Params

`Params` 页面把 URL 查询字符串显示为 Key/Value 行。勾选的非空 Key 会写回 URL；
最后一行开始输入后，程序会自动增加一个空行。

例如：

```text
page = 1
limit = 20
```

会生成：

```text
?page=1&limit=20
```

参数值按输入内容原样拼接，当前不会自动进行 URL 百分号编码。

### Authorization

支持以下类型：

- `None`：不添加认证信息，网络请求不携带凭据。
- `Basic Auth`：发送 `Authorization: Basic ...`。
- `Digest Auth`：由 Chromium 处理服务端的 Digest Challenge。

Basic Auth 示例：

```bash
curl --basic --user "demo:passwd" \
  --url "https://httpbingo.org/basic-auth/demo/passwd"
```

Digest Auth 示例：

```bash
curl --digest --user "demo:passwd" \
  --url "https://httpbingo.org/digest-auth/auth/demo/passwd/SHA-256"
```

选择 Basic 或 Digest 后，程序会忽略 Headers 页面里手工填写的
`Authorization`，使用 Authorization 页面中的用户名和密码。

### Headers

只有已勾选且 Header 名称非空的行会被发送。请求完成后，页面还会显示 Chromium
网络层实际发出的请求头。网络层自动添加的行是只读的，提示文字为
`Added by the network layer`。

无效的 Header 名称或值会在发送时被跳过。

### Body

Body 以 UTF-8 字符串上传：

- 显式设置 `Content-Type` 时使用该值。
- 未设置 `Content-Type` 且正文是有效 JSON 时，自动使用
  `application/json; charset=utf-8`。
- 其他情况使用 `text/plain; charset=utf-8`。

### cURL 编辑器

顶部编辑器识别以下常用参数：

| 功能 | 支持的参数 |
|---|---|
| URL | `--url`，或独立的 `http://`/`https://` 地址 |
| Method | `-X`、`--request` |
| Header | `-H`、`--header` |
| Body | `-d`、`--data`、`--data-raw`、`--data-binary`、`--data-urlencode`、`--json` |
| Auth | `-u`、`--user`、`--basic`、`--digest` |
| Protocol | `--http1.1`、`--http2`、`--http2-prior-knowledge`、`--http3`、`--http3-only` |

支持单引号、双引号和反斜杠续行。它是面向请求编辑的 cURL 子集解析器，
不会执行 Shell，也不支持管道、重定向、命令替换或任意 cURL 参数。通过表单修改
请求后，cURL 文本会被重新生成为规范格式，未识别的参数不会保留。

## 协议策略

| 选项 | 行为 |
|---|---|
| Auto | 使用 Chromium 默认协议协商 |
| HTTP 1.1 | 禁用 HTTP/2 和 QUIC |
| HTTP 2 | 禁用 QUIC，优先 HTTP/2，允许回退 HTTP/1.1 |
| QUIC | 严格 HTTP/3，不允许 TCP 回退，并且要求 HTTPS URL |

`Response` 中的 `Requested protocol` 表示用户选择，`Negotiated protocol` 和
`ALPN` 表示连接最终实际使用的协议。即使请求选择 HTTP/2，服务端不支持时也可能
回退到 HTTP/1.1。

请求超时时间为 60 秒。HTTP 4xx/5xx 的响应正文仍会显示，不会仅因为 HTTP 状态码
而丢弃正文。

## 环境变量

侧边栏的 `Environments` 页面用于维护多套变量：

1. 点击页面标题旁的 `+` 创建环境。
2. 设置环境名称和颜色。
3. 添加 Key/Value，并勾选需要启用的变量。
4. 点击保存图标。
5. 在请求顶部右侧的环境按钮中选择环境。

变量支持两种写法：

```text
{{base_url}}
${token}
```

例如创建：

```text
base_url = https://httpbingo.org
token    = abc123
```

请求可以写成：

```bash
curl --url "{{base_url}}/anything" \
  --header "Authorization: Bearer ${token}"
```

发送前会替换 URL、Header 名称、Header 值、Body、认证用户名和认证密码中的启用变量。
未定义、未启用或 Key 为空的变量保持原样。

环境条目支持重命名、复制和删除；历史记录还可以按环境筛选。

## Collections

Collection 是磁盘上的一个目录：

1. 打开侧边栏 `Collections`。
2. 点击右下角 `Import Collection`。
3. 选择一个目录。
4. 程序会递归显示其中的子目录和 `.cl` 请求文件。
5. 点击 `.cl` 文件即可在右侧标签页打开。

目录优先显示，其次显示 `.cl` 文件，并按名称排序。刷新按钮会重新扫描当前目录。

最小 `.cl` 文件示例：

```bash
curl --request "GET" \
  --url "https://httpbingo.org/get" \
  --header "Accept: application/json"
```

Collection 中当前只有菜单里的 `Rename` 会改变树节点显示名称，而且不会重命名磁盘
文件。`Add Request`、`Add Folder`、`Add example`、`Run`、`Export`、`Import`、
`Duplicate` 和 `Delete` 菜单项目前尚未接入实际操作。导入的 Collection 路径也不会
在重新启动后自动恢复。

## History

每次点击 `Send` 都会自动创建一条历史记录。历史记录保存的是可再次打开和复制的
cURL 请求，包含：

- URL、Method、Header 和 Body；
- 协议选择；
- Basic/Digest 类型及用户名、密码；
- 当时选择的环境名称和颜色；
- cURL 编辑器高度。

历史记录按时间倒序显示，并支持：

- 再次打开；
- 复制 cURL 字符串；
- 重命名；
- 复制；
- 删除；
- 按环境筛选。

历史记录保存的是发送时已经解析环境变量后的请求值。

## 标签页与外观

- 右上角 `+` 创建新请求标签页。
- 左上角标签列表按钮可以搜索并切换已打开的标签页。
- 请求、历史记录和环境编辑器都在主区域以标签页方式打开。
- 标题栏左侧按钮可以显示或隐藏侧边栏。
- 拖动侧边栏边缘可以调整宽度。
- 拖动 cURL 编辑器下方边缘可以调整编辑器高度。
- 标题栏菜单可以切换 Dark/Light 主题并打开 About 对话框。

## 本地数据与安全

程序把本地数据保存在用户主目录下：

```text
~/.config/crRequest/settings.json       # 主题设置
~/.config/crRequest/environments.json   # 环境变量
~/.config/crRequest/history/*.cl        # 请求历史
```

请注意：

- 环境变量值不会加密。
- Basic/Digest 用户名和密码会以明文形式写入历史 `.cl` 文件。
- 请求历史可能包含 Token、Cookie、API Key、Header 和 Body 中的敏感数据。
- 删除侧边栏中的历史记录会删除对应的本地 `.cl` 文件。

不要在共享账号或不可信设备上保存生产环境密钥。需要清理数据时，请先关闭
crRequest，再删除上述文件或目录。

## 当前限制

- Authorization 页面只支持 None、Basic 和 Digest，不支持 NTLM、Negotiate、
  OAuth 流程或自动 Token 管理；Bearer Token 可以作为普通 Header 手工填写。
- 没有代理、客户端证书、Cookie 管理或关闭 TLS 证书校验的界面。
- `Download response` 和 `Got a response` 菜单项目前没有实际行为。
- Response 以文本形式显示，不提供 JSON 树、图片预览或二进制文件保存。
- Collection 的创建、导出、复制和删除等菜单尚未实现。
- 当前没有跨启动恢复已打开标签页或已导入 Collection 的功能。
