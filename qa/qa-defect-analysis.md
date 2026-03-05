# QA Defect Analysis Skill

## Description
Log analysis and root cause finding for production defects and bugs. Analyzes error traces, identifies patterns, and provides actionable insights for fixing issues.

## Capabilities
- Analyze error logs and stack traces to identify root causes
- Identify patterns in recurring defects
- Provide detailed reproduction steps
- Assess defect severity and priority
- Recommend preventive measures

## Trigger Keywords
- "defect分析"
- "bug分析"
- "log分析"
- "错误追踪"
- "根因分析"
- "为什么报错"
- "问题定位"

## Tools
- file-read: Read log files and error traces
- grep: Search for patterns in logs
- lsp_diagnostics: Check for code issues

## Expected Input
- Error message or stack trace
- Related log files
- Steps to reproduce (if available)

## Output Format
```
## Defect Analysis Report

### Error Summary
[Brief description of the error]

### Root Cause
[Identified root cause with explanation]

### Affected Components
- Component 1
- Component 2

### Severity
- Critical / High / Medium / Low

### Recommended Fix
[Specific actionable fix recommendation]

### Prevention
[Suggestions to prevent similar issues]
```

## Example Scenarios

### Scenario 1: Production Bug Investigation
User: "用户登录时报错 'TypeError: Cannot read property of undefined'"
```
1. Ask for the full error stack trace
2. Analyze which component is undefined
3. Check if it's a null check issue
4. Provide fix recommendation
```

### Scenario 2: Recurring Issue Pattern
User: "系统每隔一段时间就报错"
```
1. Look for time-based patterns in logs
2. Check for resource leaks, session timeouts, or cache issues
3. Identify the root cause pattern
```

## Best Practices
1. Always ask for full error context when not provided
2. Look for the actual root cause, not just symptoms
3. Provide specific, actionable fixes
4. Consider edge cases and similar patterns
5. Suggest preventive measures

## Notes
- This skill focuses on technical defect analysis
- For business impact assessment, combine with product skills
- For fix implementation, use dev skills