from pytsa.tsa import *
from pytsa.tsa import SeqView_double_t as SV

import pickle
import json
import copy


# class to handle the parameters
class Parameters(object):
    def __init__ ( self, **kwargs ):
        self.__dict__ = kwargs

        def __getattr__ ( self, attr ):
            return self.__dict__[attr]

    def dump ( self, filename ):
        """
        :param filename: name of file where saving the parameters
        :type filename: basestring
        """
        self.filename = filename
        with open(self.filename, mode='w', encoding='utf-8') as f:
            json.dump(self.__dict__, f)

    def load ( self, filename ):
        """
                :param filename: name of file where loading the parameters
                :type filename: basestring
                """
        self.filename = filename
        with open(self.filename) as data_file:
            data = json.load(data_file)
        self.__dict__ = data
        return self.__dict__

    def copy ( self, param ):
        """
                :param param: parameters
              """
        self.__dict__ = copy.deepcopy(param.__dict__)
        return self.__dict__






par = Parameters()
par.load("../cfg/config.json")

Learn = SV()
strLearn = FrameIChannel(par.input, par.channel, par.len_seconds, par.gps_start_time)
strLearn.GetData(Learn)

print(Learn[0])

# output = open(par.output, 'wb')
# pickle.dump(Learn,output)
# output.close()
