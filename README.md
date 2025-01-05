# Ollama Plugin

## Basics

Either highlight some text for "context", or open a file for context and don't highlight specific text. `ctrl+e` then input the command `ai "type your prompt here"`

The LLM will replace the highlighted text with a code response to the prompt, or the entire file will be replaced.

`ctrl+z` to undo ;)

### Options

| Option       | Purpose                                                 | Default  |
| ------------ | ------------------------------------------------------- | -------- |
| ollama.model | Set the ollama model you have installed and want to use | llama3.2 |
