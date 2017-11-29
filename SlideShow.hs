import Data.Monoid
import System.IO
import System.Directory (getCurrentDirectory, listDirectory, doesDirectoryExist, copyFile)
import System.Environment (getArgs)
import System.FilePath  (splitPath, (</>))


main = getCurrentDirectory >>= \d ->
       print d >>
       flattenImages d


flattenImages :: FilePath -> IO ()
flattenImages f = listDirectory f >>= \files ->
                  mapM_ (copy f) files


copy :: FilePath -> FilePath -> IO ()
copy d f = doesDirectoryExist f >>= \isDir ->
           let path = d </> f in
           if isDir then flattenImages path
                    else copyFile path f
       
