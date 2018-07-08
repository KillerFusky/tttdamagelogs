ResumeAndHandleError = (c, ...) ->
    succeeded, errors = coroutine.resume(c, ...)
    if not succeeded
        error(errors)

export class Promise

    new: (func) =>
        @func = func

    @reject = (msg) ->
        error(msg)

    Start: () =>
        baseCoroutine = coroutine.running!
        startFunc = () ->
            resolve = (...) ->
                ResumeAndHandleError(baseCoroutine, ...)
            self.func(resolve, @@reject)
        subCoroutine = coroutine.create(startFunc)
        ResumeAndHandleError(subCoroutine)
        return coroutine.yield!

    Then: (callback) =>
        result = @Start!
        callback(result)

export async = (func) ->
    return (...) ->
        args = {...}
        coroutineFunc = () ->
            func(unpack(args))
        mainCoroutine = coroutine.create(coroutineFunc)
        ResumeAndHandleError(mainCoroutine)

export await = (promise) ->
    return promise\Start!