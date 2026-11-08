<div dir="rtl">

# 🪟 الرفع على GitHub من Windows — خطوة بخطوة

> الحالة: Git مثبّت على جهازك ✅ — يبقى إنشاء المستودع والرفع (أمرين فقط).

---

## الخطوة 1 — فك ضغط المشروع

1. حمّل **`flutter-fonts-kit.zip`** من مساحة العمل.
2. كليك يمين على الملف → **Extract All…** → **Extract**
3. سيظهر مجلد اسمه `flutter-fonts-kit`

> ⚠️ **مهم:** لا تفتح المجلد الداخلي من داخل نافذة الزيب المضغوط. لازم تُفك
> الضغط أولاً، وإلا لن يرى Git مجلد `.git`.

**تحقق سريع:** افتح المجلد — لازم ترى `pubspec.yaml` و`README.md` و`push_to_github.sh`
ثم في الشريط العلوي من مستكشف الملفات: **View → Show → Hidden items** ✅
(للتأكد أن مجلد `.git` موجود — النقطة قبله تجعله مخفياً).

---

## الخطوة 2 — أنشئ المستودع على GitHub

افتح المتصفح على **https://github.com/new** واملأ الحقول:

| الحقل | القيمة |
|---|---|
| **Repository name** | `flutter-fonts-kit` |
| **Description** | `مكتبة 13 عائلة خطية عربية ولاتينية لتطبيقات Flutter` |
| **Visibility** | Public (موصى به) أو Private |
| **Initialize this repository with:** | ❌ اترك الكل بدون علامة |
| **Add a README file** | ❌ بدون علامة |
| **Add .gitignore** | ❌ بدون علامة |
| **Choose a license** | ❌ بدون علامة |

اضغط **Create repository**.

> سترى بعدها صفحة فيها أوامر Git — **تجاهلها** واتبع الخطوة 3 (المشروع لدينا
> يحتوي commits جاهزة، فلا حاجة لأي أمر منهم).

---

## الخطوة 3 — افتح Terminal داخل مجلد المشروع

الطريقة الأسرع: داخل مجلد `flutter-fonts-kit`:

1. اكتب `cmd` في **شريط عنوان مستكشف الملفات** واضغط Enter

فستُفتح نافذة سوداء (Command Prompt) مسارها هو مجلد المشروع. تحقّق:

```cmd
git status
```

يجب أن تظهر: `On branch main` … `nothing to commit, working tree clean`

> إن ظهر `fatal: not a git repository` فأنت في المجلد الخطأ — تأكد أنك داخل
> المجلد الذي فيه `pubspec.yaml`.

---

## الخطوة 4 — المهلة الثانية: هوية Git (مرة واحدة في العمر)

```cmd
git config --global user.name "اسمك"
git config --global user.email "بريدك@example.com"
```

> استخدم نفس البريد المرتبط بحساب GitHub، وإلا لن تُنسب الـ commits لحسابك.

---

## الخطوة 5 — اربط وارفع

### على Windows استخدم `bash` لتشغيل السكربت الجاهز:

```cmd
bash push_to_github.sh ahmed-ali
```

استبدل `ahmed-ali` باسم مستخدمك في GitHub. السكربت سيقوم تلقائياً بـ:

1. استبدال `your-username` باسمك في `pubspec.yaml` و README
2. عمل commit بالتعديل
3. إضافة `origin`
4. رفع `main`

> `bash` يأتي مع Git for Windows، فسيعمل مباشرة.

### أو الأوامر اليدوية (تعمل في cmd وPowerShell أيضاً)

```cmd
git remote add origin https://github.com/ahmed-ali/flutter-fonts-kit.git
git branch -M main
git push -u origin main
```

---

## الخطوة 6 — تسجيل الدخول (أهم خطوة على Windows)

عند `git push` ستظهر نافذة **Git Credential Manager**:

### الخيار (أ) — المتصفح (الأسهل) ✅ موصى به

1. اختر **Sign in with your browser**
2. سجّل دخولك إلى GitHub
3. اضغط **Authorize**
4. انتهى — لن يسألك مرة أخرى

### الخيار (ب) — Personal Access Token

1. GitHub → صورتك → **Settings**
2. **Developer settings** (آخر القائمة اليسرى)
3. **Personal access tokens** → **Tokens (classic)**
4. **Generate new token (classic)**
5. **Note:** `flutter-fonts-kit` — **Expiration:** 90 days
6. ✅ علّم صلاحية **`repo`** (كل ما تحتها)
7. **Generate token** → انسخ الرمز (يبدأ بـ `ghp_`) فوراً — لن يظهر مرة أخرى
8. عند طلب `Password` الصق الرمز (لا كلمة مرور حسابك)

> 💡 لحفظ الرمز حتى لا يتكرر السؤال:
> ```cmd
> git config --global credential.helper manager
> ```

---

## ✅ النتيجة

ستظهر رسالة مثل:

```
branch 'main' set up to track 'origin/main'.
To https://github.com/ahmed-ali/flutter-fonts-kit.git
 * [new branch]      main -> main
```

افتح: `https://github.com/<USERNAME>/flutter-fonts-kit` — يجب أن ترى 113 ملفاً
و4 commits والغلاف في الصفحة الرئيسية.

---

## استخدام المكتبة في مشروع آخر

في `pubspec.yaml` لمشروعك:

```yaml
dependencies:
  flutter_fonts_kit:
    git:
      url: https://github.com/<USERNAME>/flutter-fonts-kit.git
      ref: main
```

ثم:

```cmd
flutter pub get
```

---

## تفعيل الموقع التجريبي (اختياري)

من صفحة المستودع: **Settings → Pages → Build and deployment → Source: GitHub Actions**

سيُنشر تلقائياً بعد كل `push` على:

```
https://<USERNAME>.github.io/flutter-fonts-kit/
```

---

## 🔧 حل المشاكل الشائعة على Windows

| المشكلة | الحل |
|---|---|
| `bash: command not found` | استخدم **Git Bash** من قائمة Start، أو نفّذ الأوامر اليدوية في الخطوة 5 |
| `fatal: not a git repository` | أنت خارج مجلد المشروع — `cd` إلى المجلد الذي فيه `pubspec.yaml` |
| `Repository not found` | اسم المستخدم/المستودع خطأ، أو المستودع لم يُنشأ بعد |
| `Authentication failed` | استخدم Token من الخطوة 6 (GitHub لا يقبل كلمة المرور) |
| `src refspec main does not match` | نفّذ `git branch -M main` قبل `push` |
| `updates were rejected` | المستودع غير فارغ: `git pull --rebase origin main` ثم `git push` |
| `filename too long` | نفّذ: `git config --global core.longpaths true` |
| `LF will be replaced by CRLF` | تحذير طبيعي على Windows — تجاهله |
| الشبكة/بروكسي يمنع الاتصال | جرّب SSH بدل HTTPS: `git remote set-url origin git@github.com:<USERNAME>/flutter-fonts-kit.git` |

---

## 📌 ملخص الطلب (انسخه في محرّك البحث لاحقاً)

```cmd
cd C:\path\to\flutter-fonts-kit
git config --global user.name "اسمك"
git config --global user.email "بريدك@example.com"
bash push_to_github.sh <USERNAME>
```

</div>
