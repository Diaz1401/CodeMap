# CodeMap: Understand Any Codebase

## App Purpose
When encountering a new codebase in an unfamiliar programming language, it can be confusing to understand what is happening. CodeMap is an app designed to help users paste any code snippet (from any language) and receive tailored context, documentation, and a learning path to better understand the code.

## Vision
- Not just AI explaining code — it builds a learning path around it.
- Helps coders understand new languages or styles.

## Core Features
| Feature                  | Description                                                                 |
|-------------------------|-----------------------------------------------------------------------------|
| 🔍 Code Language Detection | Automatically detects the language (Python, JS, etc.)                        |
| 📄 Code Summary            | High-level explanation of what the code does                                 |
| 🧩 Line-by-Line Explanation| Natural-language breakdown of each line                                      |
| 📚 Learning Path           | Custom study steps to learn language/framework/style                         |
| 📘 Glossary Builder        | AI-generated list of functions/classes/methods used with explanations        |
| 🔁 Re-ask for Clarity      | Ask follow-up questions (chat-style or pre-set)                              |

## How AI Helps
| AI Role            | Method                                                                 |
|--------------------|------------------------------------------------------------------------|
| Language detection | Basic regex or AI prompt: “What language is this?”                      |
| Summary & Breakdown| AI prompt: “Explain this code as if I’m new to the language”            |
| Glossary terms     | Extract function/class names → define using AI                          |
| Learning path      | AI generates a step-by-step: "Learn functions → learn closures → async" |

## Example User Flow
1. User pastes code snippet.
2. App detects language.
3. App provides:
   - High-level summary
   - Line-by-line explanation
   - Glossary of terms
   - Learning path
4. User can ask follow-up questions for clarity.

---

This file documents the initial idea, vision, and feature set for the CodeMap project. Some of the features may evolve based on user feedback and technical feasibility. The goal is to create a tool that not only explains code but also helps users learn and adapt to new programming languages and styles effectively.
