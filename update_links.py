import os
import re
import glob

def update_links(directory):
    html_files = glob.glob(os.path.join(directory, '*.html'))
    
    # Regex to match href="filename.html" or href="filename.html#section"
    # It will match local files safely.
    pattern = re.compile(r'href=["\']([a-zA-Z0-9_-]+)\.html(#[^"\']*)?["\']')
    
    for filepath in html_files:
        with open(filepath, 'r', encoding='utf-8') as f:
            content = f.read()
            
        # exclude index.html to / maybe? Or index.html to index which could be redirected to /
        
        # Replace href="about.html" with href="about", href="index.html" with href="/"
        def replacer(match):
            filename = match.group(1)
            hash_tag = match.group(2) if match.group(2) else ''
            
            if filename == 'index':
                return f'href="/{hash_tag}"'
            else:
                return f'href="{filename}{hash_tag}"'
                
        new_content = pattern.sub(replacer, content)
        
        if new_content != content:
            with open(filepath, 'w', encoding='utf-8') as f:
                f.write(new_content)
            print(f"Updated links in {os.path.basename(filepath)}")

if __name__ == '__main__':
    update_links(os.getcwd())
