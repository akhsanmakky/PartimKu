#!/usr/bin/env python3
# -*- coding: utf-8 -*-
import os
import re

replacements = {
    'lib/services/api_service.dart': [
        (r'^\s*// Mock jobs data\s*\n', '\n'),
        (r'^\s*// ─── [\w\s]+ ───\s*\n', '\n'),
        (r'^\s*// Exclude jobs user already applied to\s*\n', '\n'),
        (r'^\s*// Skill matching: \+3 per matching keyword\s*\n', '\n'),
        (r'^\s*// Preferred job type match: \+5\s*\n', '\n'),
        (r'^\s*// Preferred schedule match: \+4\s*\n', '\n'),
        (r'^\s*// Verified company bonus: \+2\s*\n', '\n'),
        (r'^\s*// Recency bonus \(within 3 days\): \+1\s*\n', '\n'),
    ],
    'lib/screens/user/job_detail_screen.dart': [
        (r'^\s*// apply_job_screen is in the same user folder\s*\n', '\n'),
        (r'^\s*// Gradient App Bar\s*\n', '\n'),
        (r'^\s*// Content\s*\n', '\n'),
        (r'^\s*// Company Rating Card\s*\n', '\n'),
        (r'^\s*// Description\s*\n', '\n'),
        (r'^\s*// Requirements\s*\n', '\n'),
        (r'^\s*// Posted Date\s*\n', '\n'),
    ],
    'lib/screens/user/home_screen.dart': [
        (r'^\s*// Modern App Bar\s*\n', '\n'),
        (r'^\s*// Search Bar\s*\n', '\n'),
        (r'^\s*// Active Filter Chips\s*\n', '\n'),
        (r'^\s*// Job List\s*\n', '\n'),
    ],
    'lib/screens/user/edit_profile_screen.dart': [
        (r'^\s*// Avatar Section\s*\n', '\n'),
        (r'^\s*// Form Fields\s*\n', '\n'),
        (r'^\s*// Save Button\s*\n', '\n'),
    ],
    'lib/screens/user/company_reviews_screen.dart': [
        (r'^\s*// Rating Summary Card\s*\n', '\n'),
        (r'^\s*// Rating distribution bars\s*\n', '\n'),
        (r'^\s*// Reviews List\s*\n', '\n'),
    ],
    'lib/screens/user/apply_job_screen.dart': [
        (r'^\s*// Job Summary Card\s*\n', '\n'),
    ],
    'lib/screens/splash_screen.dart': [
        (r'^\s*// Decorative background circles\s*\n', '\n'),
        (r'^\s*// Center logo\s*\n', '\n'),
        (r'^\s*// Loading indicator\s*\n', '\n'),
        (r'^\s*// Bottom version text\s*\n', '\n'),
    ],
    'lib/screens/navigation/main_navigation_screen.dart': [
        (r'^\s*// Profile Header with Gradient\s*\n', '\n'),
        (r'^\s*// Avatar\s*\n', '\n'),
        (r'^\s*// Stats Cards\s*\n', '\n'),
        (r'^\s*// Menu Items\s*\n', '\n'),
    ],
    'lib/screens/auth/login_screen.dart': [
        (r'^\s*// Gradient Header\s*\n', '\n'),
        (r'^\s*// Logo\s*\n', '\n'),
        (r'^\s*// Form Section\s*\n', '\n'),
        (r'^\s*// Login Button\s*\n', '\n'),
        (r'^\s*// Divider\s*\n', '\n'),
        (r'^\s*// Register Links\s*\n', '\n'),
    ],
    'lib/screens/auth/register_screen.dart': [
        (r'^\s*// Gradient Header Section\s*\n', '\n'),
        (r'^\s*// Form Section\s*\n', '\n'),
        (r'^\s*// Register Button\s*\n', '\n'),
        (r'^\s*// Divider with "atau"\s*\n', '\n'),
        (r'^\s*// Social Register Buttons\s*\n', '\n'),
        (r'^\s*// Login Link\s*\n', '\n'),
    ],
    'lib/screens/auth/registration_admin_screen.dart': [
        (r'^\s*// Header\s*\n', '\n'),
        (r'^\s*// Form\s*\n', '\n'),
        (r'^\s*// Register Button\s*\n', '\n'),
        (r'^\s*// Login Link\s*\n', '\n'),
    ],
    'lib/screens/company/company_chat_list_screen.dart': [
        (r'^\s*// Get unique conversation partners\s*\n', '\n'),
    ],
    'lib/screens/company/company_applicant_detail_screen.dart': [
        (r'^\s*// If initialApplicationId is set, show that one first; otherwise show all\s*\n', '\n'),
    ],
}

count = 0
for filepath, patterns in replacements.items():
    fullpath = os.path.join('c:', os.sep, 'Users', 'lenovo', 'partimku', filepath)
    if not os.path.exists(fullpath):
        print(f"SKIP: {filepath} not found")
        continue
    with open(fullpath, 'r', encoding='utf-8') as f:
        content = f.read()
    original = content
    for pattern, repl in patterns:
        content = re.sub(pattern, repl, content, flags=re.MULTILINE)
    if content != original:
        with open(fullpath, 'w', encoding='utf-8') as f:
            f.write(content)
        count += 1
        print(f"CLEANED: {filepath}")
    else:
        print(f"UNCHANGED: {filepath}")

print(f"\nDone! Cleaned {count} files.")

