

### Motivating example

~~~~
#ifndef NDEBUG
#define assert(condition) \
  if (!condition) { \
  fprintf(stderr,"assertion failed: %s, %s:%d\n", #condition, __FILE__, __LINE__); \
  exit(1); \
  }
#else
#define assert(condition) /*nothing*/
#endif
~~~~
{lang : "c"}

~~~~
macro assert(condition)
  if DEBUG
    :(
       unless ^condition
         warn "assertion failed: #{^condition.unparse}, #{__FILE__}:#{__LINE__}"
         exit 1
       end
    )
  else
    #nothing
  end
end
~~~~
{:lang="ruby"}

In LaTeX


