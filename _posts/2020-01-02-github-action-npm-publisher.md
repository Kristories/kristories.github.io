---
layout: post
title:  "GitHub Action - NPM Publisher"
---

[GitHub Action](https://github.com/features/actions) dapat digunakan untuk mem-*publish* setiap rilisan NPM *package*.

Berikut langkahnya :

### Buat *access token*

Buat *access token* baru di [NPMJS](https://www.npmjs.com). Caranya klik avatar > **Auth Tokens**, lalu klik **Create New Token**.

### Buat *secret*

Kembali ke *repository* di GitHub, pilih **Settings** > **Secrets**, lalu pilih **Add a new secret**. **Paste** token yang dibuat di NPMJS, dan beri nama `NPM_TOKEN`.

![GitHub Secrets](/assets/img/github-secrets.png)

### *Setup workflow*

*Setup workflow* baru dengan membuat file `npm_publisher.yml` di `.github/workflows` pada *repository*, seperti dibawah ini :


{% raw %}
```yml
name: NPM Publisher

on:
  release:
    types: [published]

jobs:
  publish:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v2
    - name: Setup Node
      uses: actions/setup-node@v1
      with:
        node-version: 12
        registry-url: https://registry.npmjs.org
    - name: Build package
      run: |
        npm install
    - name: Register Token
      run: |
        echo "//registry.npmjs.org/:_authToken=$NPM_TOKEN" > /home/runner/work/_temp/.npmrc
        echo "_auth=$NPM_TOKEN" >>  /home/runner/work/_temp/.npmrc
        echo "email=<email@domain.tld>" >>  /home/runner/work/_temp/.npmrc
        echo "always-auth=true" >>  /home/runner/work/_temp/.npmrc
      env:
        NPM_TOKEN: ${{ secrets.NPM_TOKEN }}
    - name: Publish
      run: npm publish

```
{% endraw %}

> Ganti `<email@domain.tld>` dengan email yang akan digunakan.

### Penggunaan

Workflow akan berjalan sesaat rilis baru dibuat.

![Workflow](/assets/img/workflow-trigger.png)
