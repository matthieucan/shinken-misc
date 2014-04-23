class Query(object):
    def __init__(self, datasource):
        self._datasource = datasource
        self._columns = []
        self._filters = []
        self._stats = []
        self._sorts = []
        self._groupby = []
        self._column_headers = False
        self._limit = None

    def _check_type(self, name, obj, types):
        if not isinstance(types, list):
            types = [types]
        for t in types:
            if isinstance(obj, t):
                return True
        types_str = '/'.join([str(e) for e in types])
        msg = '%s (%s) must be %s, got %s instead.'
        msg %= (name, obj, types_str, str(type(obj)))
        raise ValueError(msg)
    
    def columns(self, *args):
        for arg in args:
            self._check_type('Columns', arg, str)
        self._columns.extend(args)
        return self
    
    def filters(self, *args):
        for arg in args:
            self._check_type('Filters', arg, str)
        self._filters.extend(args)
        return self

    def stats(self, *args):
        for arg in args:
            self._check_type('Stats', arg, str)
        self._stats.extend(args)
        return self

    def sorts(self, *args):
        for arg in args:
            self._check_type('Sorts', arg, str)
        self._sorts.extend(args)
        return self
    
    def groupby(self, *args):
        for arg in args:
            self._check_type('Group by', arg, str)
        self._groupby.extend(args)
        return self

    def column_headers(self, val):
        self._check_type('Column headers', val, bool)
        self._column_headers = val
        return self

    def limit(self, val):
        if not isinstance(val, int):
            raise ValueError('Limit must be integer, '
                             'got %s instead' % str(type(val)))
    
    def __repr__(self):
        # datasource
        q = 'GET {0}\n'.format(self._datasource)
        
        # columns
        if self.columns:
            columns = ', '.join(self._columns)
            q += 'Columns: {0}\n'.format(columns)
        
        # filters
        for filt in self._filters:
            q += 'Filter: {0}\n'.format(filt)

        # stats
        for stat in self._stats:
            q += 'Stats: {0}\n'.format(stat)

        # column headers
        q += 'ColumnHeaders: {0}'.format(
            {True: 'On', False: 'Off'}[self._column_headers])

        return q

if __name__ == '__main__':
    q = (Query('foo')
         .columns('foo', 'bar')
         .filters('hey', 'ya')
         .stats('ploum', 'abcd')
         .sorts('lklk', 'klkl')
         .groupby('qwe', 'rty')
         .column_headers(True)
         )
    print(q)
