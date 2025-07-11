const fs = require('fs');

function removeComments(filePath) {
    const content = fs.readFileSync(filePath, 'utf8');
    
    // Supprime les commentaires en bloc /* ... */
    const noBlockComments = content.replace(/\/\*[\s\S]*?\*\//g, '');
    
    // Supprime les commentaires de ligne //
    const noComments = noBlockComments.replace(/\/\/.*/g, '');
    
    // Supprime les lignes vides consécutives
    const cleanContent = noComments.replace(/^\s*[\r\n]/gm, '\n');
    
    fs.writeFileSync(filePath, cleanContent);
}

// Usage:
// node removeComments.js <chemin_du_fichier>
if (process.argv.length > 2) {
    removeComments(process.argv[2]);
    console.log('Commentaires supprimés avec succès.');
}
