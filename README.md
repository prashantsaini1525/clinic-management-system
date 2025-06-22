# Clinic App (Ruby on Rails Beginner Project)

This is the assignment I built step-by-step as a beginner using Ruby on Rails. It’s a small app where receptionists can register patients and doctors can view them along with a graph. I made this project to learn how real web apps work.

---

## 📌 What This App Does

- One login page for both Receptionist and Doctor.
- Receptionist can **Create, Read, Update, Delete** patients.
- Doctor can only **see** the patients and a **graph** of how many were added on which days.

---

## 🧰 Tech Stack I Used

| Feature     | Tech Used                |
| ----------- | ------------------------ |
| Backend     | Ruby on Rails 8.0.2      |
| Language    | Ruby 3.4.4               |
| Database    | PostgreSQL 17            |
| Chart       | Chartkick + Groupdate    |
| Passwords   | Bcrypt (secure password) |
| Code Editor | VS Code on Windows 10    |

---

## 🛠️ How I Built It (My Learning Journey)

### Step 1: Started the Rails Project

```bash
rails new clinic_app -d postgresql
```

> This made the app folder and all default files. `-d postgresql` tells Rails to use PostgreSQL.

### Step 2: Setup PostgreSQL

- Installed PostgreSQL 17 and used **pgAdmin** to make sure it’s running.
- Used `rails db:create` to create 2 databases:

  - `clinic_app_development`
  - `clinic_app_test`

### Step 3: Added to GitHub

```bash
git init
git add .
git commit -m "Initial commit"
git remote add origin <your-repo-url>
git push -u origin main
```

### Step 4: Made User Model for Login

```bash
rails generate model User email:string password_digest:string role:string
```

> `password_digest` is used with `has_secure_password` which encrypts passwords safely.

Then I ran:

```bash
bundle install
rails db:migrate
```

Added this in the `User` model:

```ruby
has_secure_password
```

### Step 5: Made Login System

```bash
rails generate controller Sessions new create destroy
```

Updated the controller and routes to allow login and logout.

---

## 🔐 Role-Based Logic (Receptionist / Doctor)

- I created two types of users:

  - Receptionist (can manage patients)
  - Doctor (can view patients and see the graph)

Added redirection after login based on role:

```ruby
if user.role == "receptionist"
  redirect_to receptionist_dashboard_path
elsif user.role == "doctor"
  redirect_to doctor_dashboard_path
end
```

### Created test users using Rails Console

```bash
rails console

User.create!(
  email: "reception@example.com",
  password: "password123",
  password_confirmation: "password123",
  role: "receptionist"
)

User.create!(
  email: "doctor@example.com",
  password: "password123",
  password_confirmation: "password123",
  role: "doctor"
)
```

---

## 👥 Patient Management (CRUD)

```bash
rails generate scaffold Patient name:string age:integer contact:string address:string
rails db:migrate
```

Now Receptionist can:

- Add new patients
- View all patients
- Edit info
- Delete patients

---

## 📊 Graph for Doctors

Installed chart gems:

```ruby
gem 'chartkick'
gem 'groupdate'
```

In doctor dashboard controller:

```ruby
@patient_counts = Patient.group_by_day(:created_at).count
```

In view:

```erb
<%= line_chart @patient_counts %>
```

---

## 👨‍⚕️ Login Credentials

| Role         | Email                                                 | Password    |
| ------------ | ----------------------------------------------------- | ----------- |
| Receptionist | [reception@example.com](mailto:reception@example.com) | password123 |
| Doctor       | [doctor@example.com](mailto:doctor@example.com)       | password123 |

---

## ▶️ How to Run This App

### Requirements:

- Ruby 3.4.4
- Rails 8.0.2
- PostgreSQL 17 installed and running

### Commands:

```bash
bundle install
rails db:create
rails db:migrate
rails server
```

Then open browser at: `http://localhost:3000`

---

## 📹 Video Demo

I will record and attach a short video showing how the app works.

---

## ✅ Final Checklist

- [x] Code works fine ✅
- [x] Login with roles
- [x] CRUD for patients
- [x] Graph using Chartkick
- [x] Code pushed to GitHub
- [ ] Deployed (optional)
- [ ] Video demo

---

## 💬 My Thoughts

This was my first proper project in Rails. I didn’t know anything at the start, but I installed every tool step-by-step, made login, patient logic, role system, and a chart too. I now understand how backend apps are made in real life. Still learning and enjoying it! 😄

> If you're a beginner like me or an interviewer reviewing my project — thank you for checking it out!
