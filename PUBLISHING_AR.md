# سجل التغييرات في هذا الدليل وطريقة النشر على GitHub

هذا الملف يشرح بالعربي كيف ترفع المشروع على GitHub خطوة بخطوة.

---

## 1) جهّز Git على جهازك

```bash
git config --global user.name  "اسمك"
git config --global user.email "بريدك@example.com"
```

## 2) أنشئ المستودع على GitHub

### الطريقة (أ) — عبر الموقع

1. افتح <https://github.com/new>
2. الاسم: `flutter-fonts-kit`
3. اختر **Public** (أو Private حسب رغبتك)
4. **لا** تُضف README أو .gitignore أو License (المشروع يحتويهم مسبقاً)
5. اضغط **Create repository**

### الطريقة (ب) — عبر GitHub CLI

```bash
gh repo create flutter-fonts-kit --public --source=. --remote=origin --push
```

## 3) ارفع المشروع

المشروع يحتوي **commit جاهز** مسبقاً، لذلك يكفي:

```bash
cd flutter_fonts_kit
git remote add origin https://github.com/<USERNAME>/flutter-fonts-kit.git
git branch -M main
git push -u origin main
```

> استبدل `<USERNAME>` باسم حسابك على GitHub.

بعد الرفع، استبدل `your-username` باسمك في `pubspec.yaml` و`README.md`:

```bash
grep -rl "your-username" --include="*.yaml" --include="*.md" . | xargs sed -i "s/your-username/<USERNAME>/g"
git commit -am "docs: ضبط روابط المستودع" && git push
```

## 4) استخدم المكتبة في مشروعك

```yaml
dependencies:
  flutter_fonts_kit:
    git:
      url: https://github.com/<USERNAME>/flutter-fonts-kit.git
      ref: main
```

## 5) (اختياري) النشر على pub.dev

1. احذف `publish_to: none` إن وُجد وأضف:
   ```yaml
   homepage: https://github.com/<USERNAME>/flutter-fonts-kit
   ```
2. أنشئ حساباً على <https://pub.dev> واربطه بـ Google.
3. نفّذ:
   ```bash
   flutter pub publish --dry-run
   flutter pub publish
   ```

> **ملاحظة:** حجم الحزمة كبير (~11MB) بسبب ملفات الخطوط. قد يُرفض النشر على
> pub.dev إذا تجاوز الحد، لذلك يُفضّل GitHub أو تعديل قائمة الخطوط.

## 6) GitHub Pages للتطبيق التجريبي (اختياري)

الطريقة الأسهل: استخدم إجراء بناء الويب في `.github/workflows/deploy-demo.yml`
(موجود في المشروع) — يعمل تلقائياً عند كل push إلى `main` وينشر التطبيق على:

```
https://<USERNAME>.github.io/flutter-fonts-kit/
```

بعد أول تشغيل: **Settings → Pages → Source: GitHub Actions**.

---

## ملفات مفيدة في المشروع

| الملف | الوظيفة |
|---|---|
| `LICENSE` | رخصة الكود (MIT) |
| `licenses/` | تراخيص الخطوط الأصلية (OFL-1.1) |
| `tool/fetch_fonts.py` | سكربت جلب/تحديث الخطوط من Google Fonts |
| `assets/fonts/manifest.json` | فهرس الخطوط وأحجامها |
| `screenshots/` | لقطات الشاشة المستخدمة في README |
