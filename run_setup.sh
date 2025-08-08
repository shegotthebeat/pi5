```bash
#!/bin/bash
# run_setup.sh — Automatically executes .sh scripts in reverse alphabetical order

echo "🔄 Running setup scripts in reverse alphabetical order..."

# Ensure we're in the correct directory
cd "$(dirname "$0")"

for script in $(ls -1 *.sh | sort -r); do
  if [[ "$script" != "run_setup.sh" ]]; then
    echo "🚀 Executing $script"
    chmod +x "$script"
    ./"$script"
    echo "✅ Finished $script"
  fi
done

echo "🎉 All setup scripts complete."

```
