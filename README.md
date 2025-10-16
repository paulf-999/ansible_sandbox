# 🧪 Ansible Sandbox

A lightweight local environment for experimenting with **Ansible** using **Docker containers**.

This sandbox lets you practise running Ansible playbooks against disposable “nodes” (containers) on your own machine — no external infrastructure or credentials required.

---

## ⚙️ What this sandbox creates

When you complete the setup steps below, you’ll have:

* **Two Docker containers (`node1`, `node2`)**
  → These act as simulated remote hosts that Ansible can manage. Having more than one node lets you practise running playbooks across multiple hosts (e.g. parallel execution, groups, inventories).

* **An Ansible inventory (`inventory.ini`)**
  → A simple text file listing the hosts Ansible will connect to — in this case, the Docker containers.

* **A sample Ansible playbook (`test_playbook.yml`)**
  → A YAML file defining tasks that Ansible will execute on the managed nodes (e.g., pinging the hosts, creating files).

All components are **local and disposable**, so you can safely experiment and tear them down with `make clean`.

---

## 🚀 Quick start

### 1. Install dependencies

```bash
make deps
```

Installs required command-line dependencies (Ansible and related tools) using `pipx`.

---

### 2. Create test containers

```bash
docker run -d --name node1 --hostname node1 ubuntu:22.04 sleep infinity
docker run -d --name node2 --hostname node2 ubuntu:22.04 sleep infinity
```

Creates two Ubuntu containers (`node1`, `node2`) to simulate remote hosts for Ansible to manage.

---

### 3. Install Python inside the containers

Ansible requires Python on each managed host to run most modules.

```bash
docker exec -it node1 apt-get update && docker exec -it node1 apt-get install -y python3
docker exec -it node2 apt-get update && docker exec -it node2 apt-get install -y python3
```

---

### 4. Create an Ansible inventory

Create a file called `inventory.ini`:

```ini
[nodes]
node1 ansible_connection=docker
node2 ansible_connection=docker
```

Defines a host group called `nodes`, telling Ansible to connect using the Docker connection plugin instead of SSH.

---

### 5. Write a simple playbook

Create `test_playbook.yml`:

```yaml
- name: Test Ansible on local Docker containers
  hosts: nodes
  gather_facts: yes
  tasks:
    - name: Ping all nodes
      ansible.builtin.ping:

    - name: Create a test file
      ansible.builtin.file:
        path: /tmp/hello_ansible.txt
        state: touch
```

This playbook targets all hosts in the `nodes` group and performs two simple actions:

1. Confirms connectivity using the built-in `ping` module.
2. Creates a file `/tmp/hello_ansible.txt` on each node.

---

### 6. Run the playbook

```bash
ansible-playbook -i inventory.ini test_playbook.yml
```

Verify the file was created:

```bash
docker exec -it node1 ls /tmp/
docker exec -it node2 ls /tmp/
```

---

## 🧹 Housekeeping

Remove the containers when finished:

```bash
make clean
```

---

## 📘 Key Ansible Components

| Component     | Description                                                                         |
| ------------- | ----------------------------------------------------------------------------------- |
| **Inventory** | Lists the hosts or groups of hosts that Ansible manages.                            |
| **Playbook**  | A YAML file describing one or more “plays” — sets of tasks to run on defined hosts. |
| **Module**    | A reusable unit of work (e.g. `ping`, `file`, `copy`, `yum`).                       |
| **Task**      | A single module invocation within a playbook.                                       |
| **Node**      | A target system that Ansible connects to and manages (your Docker containers).      |
