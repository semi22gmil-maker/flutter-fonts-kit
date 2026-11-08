#!/usr/bin/env bash
# ============================================================================
#  سكربت رفع Flutter Fonts Kit على GitHub — أمر واحد فقط
#
#  الاستخدام:
#     ./push_to_github.sh                 # سيسألك عن اسم المستخدم
#     ./push_to_github.sh USERNAME        # مباشرة
#     ./push_to_github.sh USERNAME my-repo
#
#  متغيّرات اختيارية:
#     REMOTE_URL=git@github.com:USER/rePO.git   # لاستخدام SSH بدل HTTPS
#     SKIP_FIX=1                                # لتجاهل استبدال your-username
# ============================================================================
set -euo pipefail

GREEN=$'\033[0;32m'; YELLOW=$'\033[1;33m'; RED=$'\033[0;31m'; CYAN=$'\033[0;36m'; NC=$'\033[0m'
say()  { printf "%s\n" "$*"; }
ok()   { printf "%s✔%s %s\n" "$GREEN" "$NC" "$*"; }
warn() { printf "%s!%s %s\n" "$YELLOW" "$NC" "$*"; }
die()  { printf "%s✘ %s%s\n" "$RED" "$*" "$NC" >&2; exit 1; }

# ── 1) التحقق من البيئة ────────────────────────────────────────────────────
command -v git >/dev/null 2>&1 || die "Git غير مثبّت. ثبّته من https://git-scm.com/downloads"
git rev-parse --is-inside-work-tree >/dev/null 2>&1 || die "شغّل السكربت من داخل مجلد المشروع flutter_fonts_kit"
[[ -f pubspec.yaml ]] || die "لم أجد pubspec.yaml — تأكد أنك داخل مجلد المشروع"

USER_NAME="${1:-}"
REPO_NAME="${2:-flutter-fonts-kit}"

if [[ -z "${USER_NAME}" ]]; then
  printf "%sأدخل اسم المستخدم في GitHub (مثال: ahmed-ali): %s" "$CYAN" "$NC"
  read -r USER_NAME
  [[ -n "${USER_NAME}" ]] || die "اسم المستخدم مطلوب"
fi

REMOTE_URL="${REMOTE_URL:-https://github.com/${USER_NAME}/${REPO_NAME}.git}"

say ""
say "${CYAN}━━━ Flutter Fonts Kit → GitHub ━━━${NC}"
say "  المستودع : ${REMOTE_URL}"
say "  الفرع    : main"
say ""

# ── 2) تصحيح روابط المستودع داخل الملفات ───────────────────────────────────
if [[ "${SKIP_FIX:-0}" != "1" ]]; then
  FIXED=$(grep -rl "your-username" --include="*.yaml" --include="*.md" . 2>/dev/null || true)
  if [[ -n "${FIXED}" ]]; then
    while IFS= read -r f; do
      sed -i.bak "s/your-username/${USER_NAME}/g" "$f" && rm -f "${f}.bak"
    done <<< "${FIXED}"
    git add -A
    git -c user.name="$(git config user.name || echo 'Fonts Kit')" \
        -c user.email="$(git config user.email || echo 'kit@example.com')" \
        commit -q -m "docs: ضبط روابط المستودع على ${USER_NAME}" || true
    ok "تم استبدال your-username باسمك في $(echo "${FIXED}" | wc -l) ملف"
  fi
fi

# ── 3) ضبط remote والفرع ──────────────────────────────────────────────────
if git remote get-url origin >/dev/null 2>&1; then
  git remote set-url origin "${REMOTE_URL}"
  warn "تم تحديث رابط origin الموجود مسبقاً"
else
  git remote add origin "${REMOTE_URL}"
  ok "تم إضافة origin"
fi

git symbolic-ref -q HEAD >/dev/null && git branch -M main
ok "الفرع الحالي: main"

# ── 4) التحقق من الهوية ───────────────────────────────────────────────────
if [[ -z "$(git config user.name || true)" || -z "$(git config user.email || true)" ]]; then
  warn "لم تضبط هوية Git بعد. اضبطها بالأمرين:"
  say "   git config --global user.name  \"اسمك\""
  say "   git config --global user.email \"بريدك@example.com\""
fi

# ── 5) الرفع ──────────────────────────────────────────────────────────────
say ""
say "${YELLOW}جارٍ الرفع…${NC}"
if git push -u origin main; then
  say ""
  ok "تم الرفع بنجاح 🎉"
  say ""
  say "  ${CYAN}المستودع:${NC} https://github.com/${USER_NAME}/${REPO_NAME}"
  say ""
  say "  ${CYAN}للاستخدام في مشروع آخر:${NC}"
  say "    dependencies:"
  say "      flutter_fonts_kit:"
  say "        git:"
  say "          url: ${REMOTE_URL}"
  say "          ref: main"
  say ""
  say "  ${CYAN}لتفعيل المعاينة الحيّة على GitHub Pages:${NC}"
  say "    Settings → Pages → Source: GitHub Actions"
else
  say ""
  die "فشل الرفع. الأسباب الشائعة:
   1. لم تُنشئ المستودع على GitHub بعد → https://github.com/new
   2. اسم المستخدم أو اسم المستودع غير صحيح
   3. تحتاج Personal Access Token بدل كلمة المرور:
      Settings → Developer settings → Personal access tokens → Tokens (classic)
      ثم: git remote set-url origin https://TOKEN@github.com/${USER_NAME}/${REPO_NAME}.git"
fi
