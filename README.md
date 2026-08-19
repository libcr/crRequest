# crRequest

`crRequest` 是一个基于 Chromium 150 Network Service、Blink 和 Views 构建的桌面
开发工具，集成了 HTTP API 调试、SSH/SFTP、数据库查询和常用开发工具。它可以编辑
并发送 HTTP/HTTPS 请求、连接远程 Shell、管理远程文件、查询 SQLite 和 PostgreSQL
数据库，并直接预览 MathML、静态 HTML/CSS 和支持 JavaScript 的交互式 Web 页面。

## 主要功能

| 模块 | 主要功能 |
|---|---|
| HTTP 请求 | 支持 `GET`、`POST`、`PUT`、`PATCH`、`DELETE`，可编辑 Query 参数、请求头和请求正文 |
| 网络协议 | 支持 Auto、HTTP/1.1、HTTP/2 和严格 HTTP/3（QUIC）策略 |
| cURL | cURL 编辑器与表单视图双向同步，支持常用请求、认证和协议参数 |
| HTTP 认证 | 支持 Basic Auth 和 Digest Auth |
| 响应与诊断 | 显示实际请求头、状态行、响应头、响应正文、ALPN、协商协议和网络错误 |
| 请求管理 | 支持环境变量、请求历史、Collection 目录和多标签页 |
| SSH 终端 | 保存 SSH 连接，通过密码、私钥或 SSH agent 登录；支持文本选择、复制粘贴、内容搜索和带搜索标记的 Overlay 滚动条 |
| SFTP 文件 | 浏览远程目录，支持列表/图标视图、面包屑导航、显示隐藏文件、新建目录、上传、下载、复制、粘贴和删除 |
| 数据库 | 管理 SQLite 和 PostgreSQL 连接，浏览表与视图、编辑并运行 SQL，并以表格显示查询结果 |
| PostgreSQL 安全连接 | 支持密码、SCRAM 和客户端证书认证，可配置 TLS 校验模式、CA 证书、客户端证书和私钥 |
| 开发工具 | 提供 MathML、SVG、HTML Preview、WebView、Lottie、证书、Hash、HMAC、Base64、AEAD、时间戳、UUID、二维码、URL、JSON、JWT、CIDR、正则表达式和颜色等工具 |
| 界面 | 支持亮色/暗色主题、可隐藏和调整宽度的侧边栏，以及水平多标签页 |

## 内置开发工具

侧边栏的 `Tools` 页面集中提供下列工具。列表名称同时标明主要使用的 Chromium
模块，便于区分能力来源。

| 工具 | 能力 |
|---|---|
| `blink::SVG` | 编辑 SVG 标记并预览图像 |
| `blink::MathML` | 使用 Blink 排版 MathML 公式，实时预览并保存为 PNG |
| `blink::HTML Preview` | 渲染静态 HTML 和内联 CSS，以透明背景预览并保存为 PNG |
| `blink::WebView` | 在完整 Blink Frame 中运行 HTML、CSS 和内联 JavaScript，支持表单、键盘、鼠标、滚轮和动画交互 |
| `skottie::Lottie` | 编辑 Lottie JSON 并预览动画 |
| `net::X509Certificate` | 解析 PEM、Base64 DER 或十六进制 DER 证书 |
| `crypto::Hash` | 计算 SHA-1、SHA-256、SHA-384 和 SHA-512 |
| `crypto::HMAC` | 使用 SHA-1、SHA-256、SHA-384 或 SHA-512 计算 HMAC |
| `base::Base64` | 编码或解码 Base64 数据 |
| `crypto::AEAD` | 使用 AES-GCM 或 ChaCha20 进行认证加密和解密 |
| `base::Time` | 在 Unix 时间戳和日期时间字符串之间转换 |
| `base::Uuid` | 生成随机 UUID v4 |
| `qr_code_generator::QR Code` | 根据 UTF-8 文本生成二维码 |
| `base::URL Encoding` | 编码或解码 URL 文本 |
| `base::Hex` | 编码 UTF-8 文本或解码十六进制字节 |
| `base::JSON` | 校验并格式化 JSON |
| `base::Base64Url / JSON` | 解码 JWT Header 和 Payload，不校验签名 |
| `url::GURL` | 解析 URL 并查看规范化后的组成部分 |
| `net::CIDR` | 检查 IPv4、IPv6 和 CIDR 网段 |
| `re2::Regex` | 使用 Chromium RE2 测试正则匹配和文本替换 |
| `ui::color_utils` | 在 HEX、RGB 和 HSL 之间转换，并显示亮度与对比度 |

### `blink::MathML`

输入内容必须以 `<math>` 为根元素。预览使用 Blink 的 MathML 排版能力，适合快速
检查分式、上下标、根式、矩阵等数学标记。

示例一：二次方程求根公式。

```html
<math xmlns="http://www.w3.org/1998/Math/MathML" display="block">
  <mi>x</mi><mo>=</mo>
  <mfrac>
    <mrow><mo>−</mo><mi>b</mi><mo>±</mo><msqrt><msup><mi>b</mi><mn>2</mn></msup><mo>−</mo><mn>4</mn><mi>a</mi><mi>c</mi></msqrt></mrow>
    <mrow><mn>2</mn><mi>a</mi></mrow>
  </mfrac>
</math>
```

示例二：二阶矩阵。

```html
<math xmlns="http://www.w3.org/1998/Math/MathML" display="block">
  <mrow>
    <mo>[</mo>
    <mtable>
      <mtr><mtd><mi>a</mi></mtd><mtd><mi>b</mi></mtd></mtr>
      <mtr><mtd><mi>c</mi></mtd><mtd><mi>d</mi></mtd></mtr>
    </mtable>
    <mo>]</mo>
  </mrow>
</math>
```

### `blink::HTML Preview`

该工具面向静态、可导出的 HTML/CSS 片段。它支持内联 `<style>`，使用透明背景，
并把渲染结果裁剪后保存为 PNG；不执行 JavaScript，也不加载外部资源。

示例一：状态卡片。

```html
<style>
  .card { width: 280px; padding: 24px; border-radius: 18px;
          color: #eaf2ff; background: linear-gradient(135deg, #172554, #2563eb);
          box-shadow: 0 16px 36px rgba(37, 99, 235, .28); }
  .label { font: 600 13px sans-serif; opacity: .72; letter-spacing: .08em; }
  .value { margin-top: 8px; font: 700 34px sans-serif; }
</style>
<div class="card">
  <div class="label">REQUESTS</div>
  <div class="value">1,284</div>
</div>
```

示例二：CSS 进度条。

```html
<style>
  .panel { width: 340px; padding: 20px; border: 1px solid #dbeafe;
           border-radius: 14px; background: #fff; font: 14px sans-serif; }
  .track { height: 12px; margin-top: 12px; overflow: hidden;
           border-radius: 999px; background: #e5e7eb; }
  .bar { width: 72%; height: 100%; background: linear-gradient(90deg, #22c55e, #06b6d4); }
</style>
<div class="panel">
  <strong>Build progress</strong><span style="float:right">72%</span>
  <div class="track"><div class="bar"></div></div>
</div>
```

### `blink::WebView`

该工具是交互式 HTML Playground。页面运行在应用内嵌的 Blink Frame 中，支持内联
JavaScript、DOM 事件、表单输入、焦点、键盘、鼠标、滚轮、CSS 动画和窗口尺寸变化。
为避免预览内容访问外部环境，页面使用严格的 Content Security Policy，网络请求、
外部资源、Worker、媒体、子 Frame、插件和表单提交均被禁用。

示例一：可点击的计数器。

```html
<style>
  body { display:grid; min-height:100vh; place-items:center; font:16px sans-serif; }
  button { padding:12px 20px; border:0; border-radius:10px;
           color:white; background:#2563eb; cursor:pointer; }
</style>
<button id="counter">Clicked 0 times</button>
<script>
  let count = 0;
  const button = document.querySelector('#counter');
  button.addEventListener('click', () => {
    count += 1;
    button.textContent = `Clicked ${count} times`;
  });
</script>
```

示例二：输入过滤与动画列表。

```html
<style>
  body { margin:0; padding:32px; background:#f8fafc; font:15px sans-serif; }
  input { width:280px; padding:11px 14px; border:1px solid #cbd5e1; border-radius:10px; }
  li { width:280px; margin-top:10px; padding:12px 14px; border-radius:10px;
       list-style:none; background:white; box-shadow:0 5px 14px rgba(15,23,42,.08);
       animation:enter .25s ease both; }
  ul { padding:0; }
  @keyframes enter { from { opacity:0; transform:translateY(8px); } }
</style>
<input id="filter" placeholder="Filter components" />
<ul id="items"></ul>
<script>
  const names = ['Request Editor', 'HTML Playground', 'Database Console'];
  const input = document.querySelector('#filter');
  const list = document.querySelector('#items');
  function render() {
    const query = input.value.toLowerCase();
    list.innerHTML = names.filter(name => name.toLowerCase().includes(query))
      .map(name => `<li>${name}</li>`).join('');
  }
  input.addEventListener('input', render);
  render();
</script>
```

## 截图

### HTTP/QUIC 请求与响应

![HTTP/QUIC 请求与响应](<Screenshot From 2026-07-18 18-37-22.png>)

### 开发工具

![开发工具](<Screenshot From 2026-07-18 19-11-06.png>)

### 主题设置

![主题设置](<Screenshot From 2026-07-22 18-20-45.png>)

### SSH 终端

![SSH 终端](<Screenshot From 2026-07-22 18-21-24.png>)

### 数据库查询

![数据库查询](<Screenshot From 2026-07-23 16-46-14.png>)

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

## SSH

侧边栏的 `SSH` 页面用于管理 SSH 连接：

1. 点击页面标题右侧的 `+`。
2. 填写名称、主机、端口、用户名和认证方式。
3. 保存后点击连接条目，连接会在右侧的水平标签页中打开。

认证方式包括 SSH agent、密码和私钥。连接配置保存在
`~/.config/crRequest/ssh_connections.json`；密码和私钥口令只保留在当前进程内存中，
不会写入配置文件。程序默认使用 `~/.ssh/known_hosts` 校验服务器主机密钥；只有勾选
首次使用时信任，才会把未知主机密钥写入该文件。当前会话页提供基础命令输入和文本
输出，不是完整的 ANSI/VT 终端模拟器。

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
~/.config/crRequest/ssh_connections.json # SSH 连接配置（不含密码和口令）
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
- `blink::MathML` 和 `blink::HTML Preview` 的输入上限均为 256 KiB；
  `blink::WebView` 的输入上限为 512 KiB。
- `blink::HTML Preview` 仅支持静态 HTML 和内联 CSS，不支持脚本、事件处理器、链接、
  图片、媒体、外部字体或网络资源。
- `blink::WebView` 支持内联 JavaScript，但不提供网络访问、持久化存储、插件、外部
  字体、图片、媒体、Worker 或嵌套页面能力。
