let SRC_DIR = 'pkg/main/default';

let gulp = require('gulp');
let $ = require('gulp-load-plugins')( { pattern: ['gulp-*', 'gulp.*', 'del'] } );


/**
 * A task to replace all instances of the Billing namespace provided with a specified replacement.
 */
gulp.task('changeBillingPrefix', () => {
    // Identify the prefix we want to replace, and the prefix we want to use as a replacement.
    let fromPrefix = _retrieveAndValidatePrefix('--from', 'blng');
    let toPrefix = _retrieveAndValidatePrefix('--to', 'blng2');

    // Now construct the regular expression we'll be using to replace the source prefix in files.
    let toRegex = _buildPrefixRegex(fromPrefix);
    // First we replace references to the CPQ prefix within files.
    console.log(`Replacing ${fromPrefix} with ${toPrefix} using regular expression '${toRegex}'...`);
    return _executeGulpReplace(`${SRC_DIR}`, toRegex, toPrefix)
        .on('end', () => {
            // Then we rename files whose names contain the CPQ prefix.
        	let pattern = `/**/${fromPrefix}*-meta.xml`;
            console.log(`Finding and renaming files matching '${SRC_DIR}${pattern}'...`);
            _executeGulpRename(`${SRC_DIR}`, pattern, toRegex, toPrefix);

            // Rename folders whose names contain the CPQ prefix.
        	pattern = `/**/${fromPrefix}*/**/*`;
            console.log(`Finding and renaming folders matching '${SRC_DIR}${pattern}'...`);
            return _executeGulpRename(`${SRC_DIR}`, pattern, toRegex, toPrefix);
        })
});

function _retrieveAndValidatePrefix(prefixArg, defaultValue) {
    let prefix = null;
    let prefixIndex = process.argv.indexOf(prefixArg);
    // If the user included the target argument, retrieve and validate their input.
    if (prefixIndex > -1) {
        prefix = process.argv[prefixIndex + 1];
        if (prefix === '' || prefix == null) {
            // If the given value is null or an empty string, we need to fail so we have something to replace.
            throw Error(`ERROR: ${prefixArg} cannot specify a null or empty value.`);
        } else if (prefix.match(/[^A-Za-z0-9]/g)) {
            // If the prefix is non-alphanumeric, we need to fail.
            throw Error(`ERROR: ${prefixArg} can only specify alphanumeric values.`);
        } else {
            // If none of those validations failed, we're free to return the prefix.
            return prefix;
        }
    } else {
        console.log(`No value specified for '${prefixArg}'. Defaulting to '${defaultValue}'.`);
        return defaultValue;
    }
}

function _buildPrefixRegex(oldPrefix, regexStart, regexEnd) {
    let i, len;
    let regexSrc = regexStart || "";
    for (i = 0, len = oldPrefix.length; i < len; i++)  {
        let charCode = oldPrefix.charCodeAt(i);
        let charVal = oldPrefix[i];
        // If the i-th character of the prefix is a letter, add it as both uppercase and lowercase. Otherwise, add it as is.
        if ((charCode > 64 && charCode < 91) || (charCode > 96 && charCode < 123)) {
            regexSrc += '[' + charVal.toUpperCase() + '|' + charVal.toLowerCase() + ']';
        } else {
            regexSrc += charVal;
        }
    }
    if (regexEnd) {
        regexSrc += regexEnd;
    }
    return new RegExp(regexSrc, 'g');
}

function _executeGulpReplace(path, regex, replacement) {
    return gulp.src(path + '/**')
        .pipe($.replace(regex, replacement))
        .pipe(gulp.dest(path));
}

function _executeGulpRename(rootDir, filePattern, regex, replacement) {
    let pathsToDeleteAsSet = new Set();
    return gulp.src(`${rootDir}${filePattern}`)
        .pipe($.rename((path) => {
            // First, reconstruct the file's full path.
            let fullPath = (path.dirname == '' ? '' : path.dirname + '/') + path.basename + path.extname;

            // Then, perform the rename. This is done by replacing all instances of the regex with the replacement in
            // both the directory path and the filename itself.
            path.dirname = path.dirname.replace(regex, replacement);
            path.basename = path.basename.replace(regex, replacement);

            // Finally, we'll need to delete either the file or one of its parent directories. The way we'll figure out
            // what we need to delete is by examining the path, finding the first match to the regex, and then cutting
            // that off as soon as possible.
            //
            // Frustratingly, regexes aren't reusable, so we need to create a new regex every time.
            let regexCopy = RegExp(regex.source, regex.flags);
            regexCopy.exec(fullPath);
            if (regexCopy.lastIndex > 0) {
                // If the regex found a match, we want to find the next instance of '/' after that point, since that's
                // the transition to a new directory.
                let nextSlashIndex = fullPath.indexOf('/', regexCopy.lastIndex);
                // If there's a slash before the end of the path, then we want to take only that much. Otherwise, we want the whole path.
                let pathToDelete = nextSlashIndex > 0 ? fullPath.slice(0, nextSlashIndex) : fullPath;
                pathsToDeleteAsSet.add(`${rootDir}/${pathToDelete}`);
            }
        }))
        .pipe(gulp.dest(rootDir))
        .on('end', () => {
            let pathsToDeleteAsArray = [];
            pathsToDeleteAsSet.forEach((path) => {
                pathsToDeleteAsArray.push(path);
            });
            return $.del(pathsToDeleteAsArray);
        });
}