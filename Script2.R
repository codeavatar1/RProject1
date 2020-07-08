library('quantmod')
library('dplyr')

#OneDrive path 
directory = 'C:\\Users\\bvh8924\\OneDrive\\apps\\tradestation\\'
fname = "ESH19 March6 5min.txt"
fname = paste(directory, fname, sep = '')
#df <- read.csv(file = 'ESH19.txt', header = TRUE)
df <- read.csv(file = fname, header = TRUE)
m1 <- as.matrix(df[, c('High', 'Low', 'Close')])
nrow(m1)
colnames(m1) <- c('High', 'Low', 'Close')
typeof(m1)
ncol(m1)
nrow(m1)
colnames(m1)




getPivots <- function(m, y) {


    #avg1<-(m[1]+ m[2]+ m[3])/3
    avg1 <- mean(m)
    if (y == 1) retval <- avg1
    if (y == 2) retval <- 2 * avg1 - m[1]
    if (y == 3) retval <- avg1 - (m[1] - m[2])
    if (y == 4) retval <- 2 * avg1 - m[2]
    if (y == 5) retval <- avg1 + (m[1] - m[2])

    return(signif(retval, 6))

}

#KeyreersalDn function
keyReversalDn <- function(mat1) {
    mat1 <- as.matrix(mat1)
    mlen <- nrow(mat1)

        vKeyDn <- vector()

for (i in mlen:2){
        if (mat1[i, 1] > mat1[i - 1, 1]) {
            if (mat1[i, 3] < mat1[i - 1, 3]) { 
                vKeyDn[i] = mat1[i, 1]
            } else vKeyDn[i] = 0.0
            } else vKeyDn[i] = 0.0

    }
    vKeyDn[1] = 0.0
    return(vKeyDn)

}
#KeyREversalUp
#KeyUp reversal function
keyReversalUp <- function(mat1) {
    mat1 <- as.matrix(mat1)
    mlen <- nrow(mat1)
    vKeyUp <- vector()


    for (i in mlen:2) {
        if (mat1[i, 2] < mat1[i - 1, 2]) {
            if (mat1[i, 3] > mat1[i - 1, 3]) {
                vKeyUp[i] = mat1[i, 2]
            } else vKeyUp[i] = 0.0
            } else vKeyUp[i] = 0.0

    }
    vKeyUp[1] = 0.0
    return(vKeyUp)

}



pSx <- apply(m1, 1, mean)
signif(pSx, 5)
mfinal <- matrix(pSx,, 1)
#pS1
pS1 <- apply(m1, 1, function(x) getPivots(x, 2))

mpS1 <- matrix(pS1,, 1)
mfinal <- cbind(mfinal, mpS1)
#pS2
pS2 <- apply(m1, 1, function(x) getPivots(x, 3))
mpS2 <- matrix(pS2,, 1)
mfinal <- cbind(mfinal, mpS2)
#pR1
pR1 <- apply(m1, 1, function(x) getPivots(x, 4))
mpR1 <- matrix(pR1,, 1)
mfinal <- cbind(mfinal, mpR1)
#pR2
pR2 <- apply(m1, 1, function(x) getPivots(x, 5))
mpR2 <- matrix(pR2,, 1)
mfinal <- cbind(mfinal, mpR2)
colnames(mfinal) <- c('pSx', 'pS1', 'pS2', 'pR1', 'pR2')
#Finally attach teh mfinal to m1
mfinal <- cbind(m1, mfinal)
#shift function syntax 
shift <- function(d, k) rbind(tail(d, k), head(d, - k), deparse.level = 0)
#shift <- function(d, k) rbind(tail(d, k), head(#d, - k), deparse.level = 0)
PrevClose <- as.vector(mfinal[, c('Close')])
length(PrevClose)
shifted <- shift(PrevClose, 1)
shifted = as.matrix(shifted[2,])
shifted = rbind(c(0), shifted)
nrow(shifted)
ncol(shifted)
colnames(shifted) <- c('PrevClose')
mfinal <- cbind(mfinal, shifted)



TR <- function(x) {
    h = x[1]
    l = x[2]
    pc = x[3]
    if (pc > h) h = pc
    else if (pc < l) l = pc
    return(h - l)
}
fATRVol <- function(x) {
    pc = x[1]
    tr = x[2]
    atrvol = (tr / pc) * 100
    atrvol = signif(atrvol, 3)
    return(atrvol)
}
TR <- apply(mfinal[, c('High', 'Low', 'PrevClose')], 1, function(x) TR(x))
mfinal <- cbind(mfinal, TR)
ATRVol <- apply(mfinal[, c('PrevClose', 'TR')], 1, function(x) fATRVol(x))
mfinal <- cbind(mfinal, ATRVol)
PChg <- signif(diff(signif(log(mfinal[, c('Close')]), 5)) * 100, 3)
PChg <- append(PChg, 0, 0)
PChg <- matrix(PChg)
colnames(PChg) <- c('PChg')
mfinal <- cbind(mfinal, PChg)

##Key REversalUp
keyup <- as.matrix(keyReversalUp(mfinal))
colnames(keyup) <- c('KeyUp')
mfinal <- cbind(mfinal, keyup)
#KeyReversaldn
keydn <- as.matrix(keyReversalDn(mfinal))
colnames(keydn) <- c('KeyDn')
mfinal <- cbind(mfinal, keydn)


mfinal <- apply(mfinal, 2, rev)
rownames(mfinal) <- seq_len(nrow(mfinal))
#mfinal <- t(mfinal)
#output <- mfinal[, 1:10]
outfile <-  paste(directory,'mfinal.txt' , sep = '')
write.csv(mfinal, file = outfile)
#write.csv(output, file = 'mfinal.txt')

