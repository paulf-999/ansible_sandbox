Here’s a **cleaner, tighter, better-formatted** version with consistent spacing, proper code formatting, clearer hierarchy, and sharper phrasing.

---

# 🧩 How This Ansible Sandbox Works

This sandbox separates **where Ansible runs** from **where changes are applied**.

---

## 1. Ansible Runs on Your Local Machine

You install and execute Ansible locally:

* `make deps` → installs Ansible
* `make run` → runs Ansible on your machine

Ansible acts only as the **automation engine**. It does *not* modify your local OS.

---

## 2. All “Server” Changes Happen Inside a Docker Container

The inventory defines the target host as:

```ini
sandbox_webserver ansible_connection=docker
```

This tells Ansible:

> **“Run tasks *inside* the `sandbox_webserver` Docker container (via `docker exec`).”**

So nginx, configuration files, and the cloned Git repo all exist **inside the container**, not on your laptop.

---

## ❓ Why Not Use `ansible_connection=local`?

If your inventory instead used:

```ini
localhost ansible_connection=local
```

then Ansible would apply everything **to your host machine**:

* nginx would be installed on your laptop
* `/opt/da-etl-dbtanalytics` would appear on your laptop
* configs, packages, and state changes would touch your real OS

This defeats the purpose of a safe, isolated environment.

---

## 🐳 Why Use Docker?

Using a container:

* keeps your machine clean
* provides an isolated, disposable “mock server”
* behaves like a real remote host
* guarantees all changes are safely sandboxed

---

### TL;DR

**Ansible runs here → changes happen there (in Docker).**

Your local OS stays untouched.
