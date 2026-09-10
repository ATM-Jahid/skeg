// Do not pass empty IDs to heuristicLookup: they match entries with no
// StartupWMClass. Resolve ties explicitly instead of relying on hash order.
function lookup(appIds, applications, byId) {
    const ids = appIds.filter(id => typeof id === "string" && id.length > 0);
    for (const id of ids) {
        const entry = byId(id);
        if (entry)
            return entry;
    }

    const entries = Array.from(applications).sort((a, b) => a.id < b.id ? -1 : a.id > b.id ? 1 : 0);
    for (const id of ids) {
        const exact = entries.find(entry => entry.startupClass === id);
        if (exact)
            return exact;
        const folded = entries.find(entry => entry.startupClass
            && entry.startupClass.toLowerCase() === id.toLowerCase());
        if (folded)
            return folded;
    }
    return null;
}
