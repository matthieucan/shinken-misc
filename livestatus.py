class Query(object):
    def __init__(self):
        self._cols = []
        self._groupby = []

    def get(self, *args):
        self._cols.extend(args)
    
    def groupby(self, ):
        pass
