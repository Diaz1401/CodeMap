# CodeMap: Understand Any Codebase

CodeMap is a Flutter app I built to learn about integrating the Gemini API (and other LLMs) with Flutter. The app serves a practical purpose: helping developers understand unfamiliar code by providing AI-powered analysis and guidance.

## What It Does

When faced with code you didn't write or in a language you're not familiar with, CodeMap helps by:

* Providing a concise summary of the code's purpose
* Breaking down the code line-by-line or by logical blocks 
* Creating a glossary of unfamiliar terms, functions, and classes
* Suggesting a personalized learning path to understand the underlying concepts

## How the AI Integration Works

| Feature           | Implementation                                                                  |
|-------------------|---------------------------------------------------------------------------------|
| Code Summary      | Prompted Gemini to generate a high-level explanation of the code                |
| Code Analysis     | Structured prompts to break down the code line-by-line                          |
| Glossary Creation | Extracted key terms (functions, classes, methods) and defined them using Gemini |
| Learning Path     | AI-generated learning path based on given code snippet                          |


## User Flow

1. Paste code in the input field
2. Press analyze button
3. View results organized into:
   * Summary
   * Line-by-line explanation
   * Glossary
   * Learning path

## Project Status

This is an active learning project focused on:
- Understanding LLM API integration with Flutter
- Exploring prompt engineering for code understanding
- Creating practical developer tools with AI assistance

Features and implementation details may change as I continue to learn and iterate on the concept.
