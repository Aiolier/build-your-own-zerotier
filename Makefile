CC = gcc
CFLAGS = -I. -Werror=return-type
LDLIBS = -lpthread

HEADERS = sys_utils.h tap_utils.h
TARGETS = vport
VPORT_OBJS = vport.o tap_utils.o

# 声明伪目标，防止与同名文件冲突
.PHONY: all clean

all: $(TARGETS)

# 链接规则：依赖 .o 文件
# Make 会自动使用隐式规则进行链接，并将 LDLIBS 加入命令
$(TARGETS): $(VPORT_OBJS)
	# 可以留空让 Make 使用隐式规则，或者显式写出：
	# $(CC) $(LDFLAGS) -o $@ $^ $(LDLIBS)

# 关键修正：明确指定 .o 文件依赖于头文件
# 这样当头文件改变时，对应的 .o 会重新编译
$(VPORT_OBJS): $(HEADERS)

# 清理规则
clean:
	rm -f $(VPORT_OBJS) $(TARGETS)
