# SSHPASS SCP Github Action

Github Action to send commands via SSHPASS-SCP


## Usage

```
- name: Run sshpass-scp commands
  uses: youxingz/sshpass-scp-action@v3
  with:
    host: ${{ secrets.SERVER_HOST }}
    user: ${{ secrets.SERVER_USER }}
    pass: ${{ secrets.SERVER_PASS }}
    port: 22
    src: ./**
    dist: /usr/local/release
```

Optional private key. In this case it will ignore the password if provided.

```
- name: Run sshpass-scp commands
  uses: youxingz/sshpass-scp-action@v3
  with:
    host: ${{ secrets.SERVER_HOST }}
    user: ${{ secrets.SERVER_USER }}
    key: ${{ secrets.SERVER_KEY }}
    src: ./**
    dist: /usr/local/release
```
