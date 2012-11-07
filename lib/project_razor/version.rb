module ProjectRazor
    # Major ProjectRazor::Client Version.
    def self.major
      0
    end

    # Minor ProjectRazor::Client Version.
    def self.minor
      1
    end

    # Patch ProjectRazor::Client Version.
    def self.patch
      0
    end

    # Pre ProjectRazor::Client Version.
    def self.pre
      nil
    end

    # ProjectRazor::Client Version.
    VERSION = [major, minor, patch, pre].compact.join(".")
  
end